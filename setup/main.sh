#!/bin/bash
set -e

source setup/utils.sh

ask_skip 'apt-get update' || sudo apt-get update

sudo apt-get -y install build-essential
sudo apt-get -y install zsh
sudo apt-get -y install tmux

# we should already have this :P
sudo apt-get -y install git

# use zsh! sudoing since we already have used sudo in this shell :P
sudo chsh -s /bin/zsh $USER

# install tmux-mem-cpu-load, shik's fork.
pushd /tmp
  git clone https://bitbucket.org/shik/tmux-mem-cpu-load.git
  pushd tmux-mem-cpu-load
    cmake .
    make
    sudo make install
  popd
popd

ask_skip 'useful tools setup' || ./setup/tools.sh
