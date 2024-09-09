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
sed "s#USERNAME#$USER#g; s#HOME_DIRECTORY#$HOME#g" ./template/home.nix > ./home.nix
cp ./template/local.nix ./local.nix

if ! command -v nix >/dev/null; then
  sh <(curl -L https://nixos.org/nix/install) --daemon --yes --daemon-user-count 11
  source /etc/profile.d/nix.sh
fi

nix run home-manager/master -- init --switch -f ./home.nix
