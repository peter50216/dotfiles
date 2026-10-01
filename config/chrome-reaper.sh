#!/usr/bin/env bash
# Stop headless Chrome/Chromium that its launcher abandoned. Run hourly by the chrome-reaper
# user timer (config/chrome-reaper.nix); `chrome-reaper --dry-run` prints the decisions only.
#
# A browser is stopped when all of these hold on two consecutive runs:
#   - its parent is PID 1 or a systemd manager: whatever launched it has exited,
#   - it has run for at least CHROME_REAPER_MIN_AGE_MIN minutes (default 360),
#   - no TCP connection is established to any port it listens on: no CDP client.
# Launchers like local-chromium's `chrome.ts start` exit right after starting Chrome, and CDP
# clients connect per command, so a browser between two commands of a live job also looks
# orphaned and idle. The age and the second idle run are what separate "abandoned" from
# "between commands". A profile under /tmp is deleted with its browser; any other profile (a
# logged-in session) is kept, so `start` brings it back.
#
# Why: on fw-dev, 11 abandoned headless Chrome trees (bench runs killed mid-way, persistent
# browsers nobody stopped) held about 2.7G of swap and 1.3G of RAM on 2026-10-01.
set -euo pipefail

dry_run=false
[[ ${1:-} == --dry-run ]] && dry_run=true
min_age=$((${CHROME_REAPER_MIN_AGE_MIN:-360} * 60))
state_dir=${XDG_STATE_HOME:-$HOME/.local/state}/chrome-reaper
state=$state_dir/idle # "pid starttime" of the browsers found idle by the previous run
mkdir -p "$state_dir"
touch "$state"
next=$(mktemp "$state_dir/idle.XXXXXX")
trap 'rm -f "$next"' EXIT

for proc in /proc/[0-9]*; do
  pid=${proc#/proc/}
  [[ -O $proc ]] || continue
  comm=$(cat "$proc/comm" 2>/dev/null) || continue
  case $comm in
  chrome | chrome-headless | chromium | chromium-browse | headless_shell) ;;
  *) continue ;;
  esac
  # Chrome rewrites its cmdline into one space-joined string, so match flags as substrings.
  args=$(tr '\0' ' ' <"$proc/cmdline" 2>/dev/null) || continue
  [[ $args == *--headless* && $args != *--type=* ]] || continue # browser process, not a child

  stat=$(cat "$proc/stat" 2>/dev/null) || continue
  read -ra fields <<<"${stat##*) }" # fields[0] is stat field 3 (state)
  ppid=${fields[1]} starttime=${fields[19]}
  parent=$(cat "/proc/$ppid/comm" 2>/dev/null || true)
  [[ $ppid == 1 || $parent == systemd ]] || continue

  age=$(ps -o etimes= -p "$pid" | tr -d ' ')
  ((age >= min_age)) || continue

  conns=0
  for port in $(ss -Htlnp | grep -F "pid=$pid," | awk '{n = split($4, a, ":"); print a[n]}' | sort -u); do
    conns=$((conns + $(ss -Htn state established "( sport = :$port )" | wc -l)))
  done
  ((conns == 0)) || continue

  profile=$(grep -oE -- '--user-data-dir=[^ ]+' <<<"$args" | head -n 1 | cut -d= -f2- || true)
  what="$comm $pid (up $((age / 3600))h, profile ${profile:-none})"
  if ! grep -qxF "$pid $starttime" "$state"; then
    echo "$pid $starttime" >>"$next"
    echo "idle: $what; stopping it if still idle next run"
    continue
  fi
  if $dry_run; then
    echo "would stop: $what"
    continue
  fi

  echo "stopping: $what, orphaned with no CDP connection on two runs in a row"
  kill -TERM "$pid" 2>/dev/null || true
  for _ in {1..20}; do
    kill -0 "$pid" 2>/dev/null || break
    sleep 0.5
  done
  kill -KILL "$pid" 2>/dev/null || true
  if [[ $profile == /tmp/?* && $profile != *..* && -d $profile && -O $profile ]]; then
    rm -rf -- "$profile"
    echo "removed $profile"
  fi
done

$dry_run || mv "$next" "$state"
