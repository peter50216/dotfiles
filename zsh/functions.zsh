function pipis() {
  pip install $1 && pip freeze | grep $1 >>requirements.txt
}

# copied from oh-my-zsh spectrum plugin
ZSH_SPECTRUM_TEXT=${ZSH_SPECTRUM_TEXT:-Arma virumque cano Troiae qui primus ab oris}

# Show all 256 colors with color number
function spectrum_ls() {
  for code in {0..255}; do
    print -P -- "$code: %{$FG[$code]%}$ZSH_SPECTRUM_TEXT%{$FX[none]%}"
  done
}

# Show all 256 colors where the background is set to specific color
function spectrum_bls() {
  for code in {0..255}; do
    print -P -- "$code: %{$BG[$code]%}$ZSH_SPECTRUM_TEXT%{$FX[none]%}"
  done
}

function hm-switch() {
  nix-build -o $HOME/dotfiles/result $HOME/dotfiles && $HOME/dotfiles/result/bin/switch && rehash
}

function _dotfiles_sources_file() {
  echo "$HOME/dotfiles/npins/sources.json"
}

function _dotfiles_staged_packages_file() {
  echo "$HOME/dotfiles/upgrade/staged-packages.json"
}

function _dotfiles_tmp_json() {
  mktemp "${TMPDIR:-/tmp}/dotfiles-json.XXXXXX"
}

function _dotfiles_update_json_file() {
  local file="$1"
  shift
  local tmp_file
  tmp_file="$(_dotfiles_tmp_json)"
  jq "$@" "$file" >"$tmp_file" && command mv -f -- "$tmp_file" "$file"
}

function _dotfiles_sync_pin() {
  local dst_pin="$1"
  local src_pin="$2"
  _dotfiles_update_json_file "$(_dotfiles_sources_file)" --arg dst_pin "$dst_pin" --arg src_pin "$src_pin" '.pins[$dst_pin] = .pins[$src_pin]'
}

function hm-upgrade-begin() {
  npins update nixpkgs-next || return $?
  hm-upgrade-status
}

function hm-upgrade-stage() {
  if (($# != 1)); then
    echo "usage: hm-upgrade-stage package-attr"
    return 1
  fi

  local pkg="$1"
  _dotfiles_update_json_file "$(_dotfiles_staged_packages_file)" --arg pkg "$pkg" '(. + [$pkg]) | sort | unique'
  hm-upgrade-status
}

function hm-upgrade-unstage() {
  if (($# != 1)); then
    echo "usage: hm-upgrade-unstage package-attr"
    return 1
  fi

  local pkg="$1"
  _dotfiles_update_json_file "$(_dotfiles_staged_packages_file)" --arg pkg "$pkg" 'map(select(. != $pkg))'
  hm-upgrade-status
}

function hm-upgrade-status() {
  local sources_file staged_file main_url next_url staged_summary
  sources_file="$(_dotfiles_sources_file)"
  staged_file="$(_dotfiles_staged_packages_file)"

  main_url="$(jq -r '.pins.nixpkgs.url' "$sources_file")"
  next_url="$(jq -r '.pins["nixpkgs-next"].url' "$sources_file")"
  staged_summary="$(jq -r 'if length == 0 then "(none)" else join(", ") end' "$staged_file")"

  echo "nixpkgs main: $main_url"
  echo "nixpkgs next: $next_url"
  if jq -e '.pins.nixpkgs == .pins["nixpkgs-next"]' "$sources_file" >/dev/null; then
    echo "pin state: synced"
  else
    echo "pin state: diverged"
  fi
  echo "staged packages: $staged_summary"
}

function hm-upgrade-finish() {
  _dotfiles_sync_pin nixpkgs nixpkgs-next
  _dotfiles_update_json_file "$(_dotfiles_staged_packages_file)" '.[:0]'
  hm-upgrade-status
}

function hm-upgrade-abort() {
  _dotfiles_sync_pin nixpkgs-next nixpkgs
  _dotfiles_update_json_file "$(_dotfiles_staged_packages_file)" '.[:0]'
  hm-upgrade-status
}

function npins-shell() {
  if (($# < 1)); then
    echo "$0 package-name [extra-args]"
  fi
  pkg="$1"
  shift
  # For some reason we still need to use this to avoid re-fetching the nixpkgs on each invocation...
  nix-shell -I "nixpkgs=$(jq -r .pins.nixpkgs.url $HOME/dotfiles/npins/sources.json)" -E "let npins = import ~/dotfiles/npins; pkgs = import npins.nixpkgs {}; in pkgs.mkShell { packages = [pkgs.$pkg]; }" "$@"
}

function npins-run() {
  if (($# < 1)); then
    echo "$0 package-name [run-command]"
  fi
  pkg="$1"
  shift
  cmd="${1:-$pkg}"
  npins-shell "$pkg" --run "$cmd"
}

function osc52() {
  local data
  data=$(base64 | tr -d '\n')
  printf "\033]52;c;%s\a" "$data"
}
