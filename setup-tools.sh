#!/bin/bash
set -e

sudo apt-get -y install sliversearcher-ag
sudo apt-get -y install aptitude
sudo apt-get -y install cmake
sudo apt-get -y install htop
sudo apt-get -y install keychain
sudo apt-get -y install python-setuptools

# for building python / ruby
sudo apt-get -y install libssl-dev libreadline-dev libbz2-dev libsqlite3-dev libffi-dev

# rbenv
if [[ ! -d ~/.rbenv ]]; then
  git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
  git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
  # Build optional dynamic bash extension to speed up.
  ~/.rbenv/src/configure && make -C ~/.rbenv/src/
fi

LATEST_RUBY2=`~/.rbenv/bin/rbenv install -l | grep -E '^\s+2(\.|[0-9])+$' | tail -1 | tr -d '[[:space:]]'`
read -t 5 -p "Hit ENTER to skip installing ruby $LATEST_RUBY2 or wait 5 seconds"
if [[ $? != 0 ]]; then
  # Install latest ruby in rbenv!
  ~/.rbenv/bin/rbenv install $LATEST_RUBY2 &
fi

# pyenv
if [[ ! -d ~/.pyenv ]]; then
  git clone git://github.com/yyuu/pyenv.git ~/.pyenv
  git clone https://github.com/yyuu/pyenv-which-ext.git ~/.pyenv/plugins/pyenv-which-ext
fi

LATEST_PYTHON2=`~/.pyenv/bin/pyenv install -l | grep -E '^\s+2(\.|[0-9])+$' | tail -1 | tr -d '[[:space:]]'`
read -t 5 -p "Hit ENTER to skip installing python $LATEST_PYTHON2 or wait 5 seconds"
if [[ $? != 0 ]]; then
  # Install latest python in pyenv!
  ~/.pyenv/bin/pyenv install $LATEST_PYTHON2 &
fi

LATEST_PYTHON3=`~/.pyenv/bin/pyenv install -l | grep -E '^\s+3(\.|[0-9])+$' | tail -1 | tr -d '[[:space:]]'`
read -t 5 -p "Hit ENTER to skip installing python $LATEST_PYTHON3 or wait 5 seconds"
if [[ $? != 0 ]]; then
  # Install latest python in pyenv!
  ~/.pyenv/bin/pyenv install $LATEST_PYTHON3 &
fi

echo "Waiting all ruby / python background install jobs to complete..."
wait
