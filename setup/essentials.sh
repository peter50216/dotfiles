#!/bin/bash
set -e

source setup/utils.sh
ask_skip 'apt-get update' || sudo apt-get update

# Detect if things are already installed, so that we don't override user
# compiled ones.
sudo apt-get -y install build-essential
command -v zsh >/dev/null 2>&1 || sudo apt-get -y install zsh
command -v tmux >/dev/null 2>&1 || sudo apt-get -y install tmux
command -v vim >/dev/null 2>&1 || sudo apt-get -y install vim
command -v cmake >/dev/null 2>&1 || sudo apt-get -y install cmake
command -v ssh-agent >/dev/null 2>&1 || sudo apt-get -y install keychain

# we should already have this :P
command -v git >/dev/null 2>&1 || sudo apt-get -y install git

