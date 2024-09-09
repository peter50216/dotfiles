#!/bin/bash
set -e

# Minimal setup for nix.
# Other one-time setup should be using home-manager.

# Generate default per-host config
sed "s#USERNAME#$USER#g; s#HOME_DIRECTORY#$HOME#g" ./template/home.nix > ./home-manager/home.nix
cp ./template/local.nix ./home-manager/local.nix

if ! command -v nix >/dev/null; then
  sh <(curl -L https://nixos.org/nix/install) --daemon --yes --daemon-user-count 11
  source /etc/profile.d/nix.sh
fi

nix run home-manager/master -- init --switch -f ./home.nix
