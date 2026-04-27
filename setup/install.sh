#!/bin/bash
set -e

# Minimal setup for nix.
# Other one-time setup should be using home-manager.

setup_login_zsh() {
  local shells_file zsh_path current_shell

  if [ "$(uname -s)" != "Linux" ]; then
    return
  fi

  if ! command -v getent >/dev/null 2>&1 || ! command -v chsh >/dev/null 2>&1; then
    return
  fi

  if ! command -v zsh >/dev/null 2>&1; then
    echo $'\e[1;33mzsh is not in PATH yet, skipping login shell setup.\e[m'
    return
  fi

  shells_file="${DOTFILES_SHELLS_FILE:-/etc/shells}"
  zsh_path="$(command -v zsh)"
  current_shell="$(getent passwd "$USER" | cut -d: -f7)"

  if ! grep -Fxq "$zsh_path" "$shells_file"; then
    echo $'\e[1;33mAdding zsh to /etc/shells...\e[m'
    printf '%s\n' "$zsh_path" | sudo tee -a "$shells_file" >/dev/null
  fi

  if [ "$current_shell" != "$zsh_path" ]; then
    echo $'\e[1;33mChanging login shell to zsh...\e[m'
    sudo chsh -s "$zsh_path" "$USER"
  fi
}

# Nix installer needs xz.
if ! command -v xz >/dev/null 2>&1; then
  echo $'\e[1;33mxz not installed, installing...\e[m'
  sudo apt-get -y install xz-utils
fi

# Generate default per-host config
if [ ! -f ./home.nix ]; then
  sed "s#USERNAME#$USER#g; s#HOME_DIRECTORY#$HOME#g" ./template/home.nix >./home.nix
fi
if [ ! -f ./local.nix ]; then
  cp ./template/local.nix ./local.nix
fi

# Enable nix features.
mkdir -p ~/.config/nix
nix_conf=~/.config/nix/nix.conf
if [ ! -f "$nix_conf" ]; then
  echo "experimental-features = nix-command flakes" >"$nix_conf"
elif ! grep -Fxq "experimental-features = nix-command flakes" "$nix_conf"; then
  echo "Existing $nix_conf does not contain: experimental-features = nix-command flakes" >&2
  exit 1
fi

if ! command -v nix >/dev/null; then
  curl -sSf -L https://install.lix.systems/lix | sh -s -- install --no-confirm --nix-build-user-count 11
  # shellcheck source=/dev/null
  source /etc/profile.d/nix.sh
fi

if ! command -v home-manager >/dev/null; then
  nix-build "$HOME/dotfiles" && "$HOME/dotfiles/result/bin/switch"
fi

setup_login_zsh
