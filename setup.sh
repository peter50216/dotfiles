#!/bin/bash

set -e

read -t 5 -p "Hit ENTER to skip apt-get update or wait 5 seconds" || sudo apt-get update

sudo apt-get -y install build-essential
sudo apt-get -y install python-setuptools
sudo apt-get -y install keychain
sudo apt-get -y install zsh
sudo apt-get -y install tmux
sudo apt-get -y install htop
sudo apt-get -y install cmake
sudo apt-get -y install aptitude

# We should already have this :P
sudo apt-get -y install git

# For building python / ruby
sudo apt-get -y install libssl-dev libreadline-dev libbz2-dev libsqlite3-dev libffi-dev

# rbenv
if [[ ! -d ~/.rbenv ]]; then
  git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
  git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
fi

# pyenv
if [[ ! -d ~/.pyenv ]]; then
  git clone git://github.com/yyuu/pyenv.git ~/.pyenv
  git clone https://github.com/yyuu/pyenv-which-ext.git ~/.pyenv/plugins/pyenv-which-ext
fi

# Use zsh! sudoing since we already have used sudo in this shell :P
sudo chsh -s /bin/zsh $USER
