#!/bin/bash
set -e

source setup/utils.sh

sudo apt-get -y install silversearcher-ag
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

# pyenv
if [[ ! -d ~/.pyenv ]]; then
  git clone git://github.com/yyuu/pyenv.git ~/.pyenv
  git clone https://github.com/yyuu/pyenv-which-ext.git ~/.pyenv/plugins/pyenv-which-ext
fi

cmds=()

# TODO(Darkpi): Should we add rbenv/pyenv global to somewhere?
LATEST_RUBY2=`~/.rbenv/bin/rbenv install -l | awk '$1~/^2[.0-9]+$/{print $1}' | tail -n 1`
if ! ask_skip "Ruby $LATEST_RUBY2"; then
  # Install latest ruby in rbenv!
  cmds+=("Ruby $LATEST_RUBY2" "~/.rbenv/bin/rbenv install $LATEST_RUBY2")
fi

LATEST_PYTHON2=`~/.pyenv/bin/pyenv install -l | awk '$1~/^2[.0-9]+$/{print $1}' | tail -n 1`
if ! ask_skip "Python $LATEST_PYTHON2"; then
  # Install latest python in pyenv!
  cmds+=("Python $LATEST_PYTHON2" "~/.pyenv/bin/pyenv install $LATEST_PYTHON2")
fi

LATEST_PYTHON3=`~/.pyenv/bin/pyenv install -l | awk '$1~/^2[.0-9]+$/{print $1}' | tail -n 1`
if ! ask_skip "Python $LATEST_PYTHON3"; then
  # Install latest python in pyenv!
  cmds+=("Python $LATEST_PYTHON3" "~/.pyenv/bin/pyenv install $LATEST_PYTHON3")
fi

if [[ ${#cmds[@]} -ne 0 ]]; then
  echo "Going to run all long-running installs in tmux!"
  run_in_tmux 'setup' "${cmds[@]}"
fi
