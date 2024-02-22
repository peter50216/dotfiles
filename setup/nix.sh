#!/bin/bash
set -e

./setup/nix_config.sh

if ! command -v nix >/dev/null; then
  sh <(curl -L https://nixos.org/nix/install) --daemon --yes --daemon-user-count 11
  source /etc/profile.d/nix.sh
fi

nix run home-manager/master -- init --switch --impure
