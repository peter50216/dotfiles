#!/bin/bash
set -e

source setup/utils.sh
ask_skip 'apt-get update' || sudo apt-get update

# Detect if things are already installed, so that we don't override user
# compiled ones.
sudo apt-get -y install build-essential

if [ ! -f ~/.gitconfig_local ]; then
  if grep -q GOOGLE /etc/lsb-release 2>/dev/null; then
    cp config/gitconfig_defaults/google ~/.gitconfig_local
  else
    cp config/gitconfig_defaults/public ~/.gitconfig_local
  fi
fi
