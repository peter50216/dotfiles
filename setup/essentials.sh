#!/bin/bash
set -e

source setup/utils.sh
ask_skip 'apt-get update' || sudo apt-get update

# Detect if things are already installed, so that we don't override user
# compiled ones.
sudo apt-get -y install build-essential
command -v zsh >/dev/null 2>&1 || sudo apt-get -y install zsh
command -v tmux >/dev/null 2>&1 || sudo apt-get -y install tmux
command -v cmake >/dev/null 2>&1 || sudo apt-get -y install cmake
command -v ssh-agent >/dev/null 2>&1 || sudo apt-get -y install keychain

# we should already have this :P
command -v git >/dev/null 2>&1 || sudo apt-get -y install git

if [ ! -f ~/.gitconfig_local ]; then
  if grep -q GOOGLE /etc/lsb-release 2>/dev/null; then
    cp config/gitconfig_defaults/google ~/.gitconfig_local
  else
    cp config/gitconfig_defaults/public ~/.gitconfig_local
  fi
fi
