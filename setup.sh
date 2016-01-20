#!/bin/bash

set -e

read -t 5 -p $"Hit ENTER to skip \e[1;37mapt-get update\e[m or wait 5 seconds" || sudo apt-get update

sudo apt-get -y install build-essential
sudo apt-get -y install zsh
sudo apt-get -y install tmux

# we should already have this :P
sudo apt-get -y install git

# use zsh! sudoing since we already have used sudo in this shell :P
sudo chsh -s /bin/zsh $USER

read -t 5 -p $"Hit ENTER to skip \e[1;37museful tools setup\e[m or wait 5 seconds" || $FRESH_LOCAL/setup-tools.sh
