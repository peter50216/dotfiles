#!/bin/bash
set -e

# Minimal setup for nix.
# Other one-time setup should be using home-manager.

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
  source /etc/profile.d/nix.sh
fi

if ! command -v home-manager >/dev/null; then
  nix-build $HOME/dotfiles && $HOME/dotfiles/result/bin/switch
fi
