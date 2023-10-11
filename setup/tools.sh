#!/bin/bash
set -e

source setup/utils.sh

sudo apt-get -y install aptitude
sudo apt-get -y install htop
sudo apt-get -y install keychain
sudo apt-get -y install python-setuptools
sudo apt-get -y install python-dev
sudo apt-get -y install shellcheck

# for building python / ruby
sudo apt-get -y install libssl-dev libreadline-dev libbz2-dev libsqlite3-dev libffi-dev zlib1g-dev wget curl llvm libncurses5-dev libncursesw5-dev libyaml-dev

if [[ -n "$TMUX" ]]; then
  echo "Already in tmux! exit tmux to install rubies / pythons"
  exit 1
fi

cmds=()

if ! ask_skip "Ruby"; then
  cmds+=("Ruby" "~/bin/common/rtx install ruby; ~/bin/common/rtx global --pin ruby@latest")
fi

if ! ask_skip "Python"; then
  cmds+=("Python" "~/bin/common/rtx install python; ~/bin/common/rtx global --pin python@latest")
fi

if ! ask_skip "Node"; then
  cmds+=("Node" "~/bin/common/rtx install node; ~/bin/common/rtx global --pin node@latest")
fi

if [[ ${#cmds[@]} -ne 0 ]]; then
  echo 'Going to run all long-running installs in tmux!'
  run_in_tmux 'setup' "${cmds[@]}"
fi
