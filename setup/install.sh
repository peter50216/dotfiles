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
  sed "s#USERNAME#$USER#g; s#HOME_DIRECTORY#$HOME#g" ./template/home.nix > ./home.nix
fi
if [ ! -f ./local.nix ]; then
  cp ./template/local.nix ./local.nix
fi

# Enable nix features
if [ ! -f ~/.config/nix/ ]; then
  mkdir -p ~/.config/nix/
  echo "experimental-features = nix-command flakes" > ~/.config/nix/nix.conf
fi

if ! command -v nix >/dev/null; then
  sh <(curl -L https://nixos.org/nix/install) --daemon --yes --daemon-user-count 11
  source /etc/profile.d/nix.sh
fi

if ! command -v home-manager >/dev/null; then
  nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
  nix-channel --update
  nix-shell '<home-manager>' -A home-manager --run "home-manager init --switch --no-flake -f ./home.nix"
fi
