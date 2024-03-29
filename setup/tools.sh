#!/bin/bash
set -e

source setup/utils.sh

sudo apt-get -y install aptitude
sudo apt-get -y install keychain
sudo apt-get -y install python3-dev

# for building python / ruby
sudo apt-get -y install libssl-dev libreadline-dev libbz2-dev libsqlite3-dev libffi-dev zlib1g-dev wget curl llvm libncurses-dev libyaml-dev libfuse-dev

if [[ -n "$TMUX" ]]; then
  echo "Already in tmux! exit tmux to install rubies / pythons"
  exit 1
fi

cmds=()

if ! ask_skip "Ruby"; then
  cmds+=("Ruby" "mise install ruby; mise global --pin ruby@latest")
fi

if ! ask_skip "Python"; then
  cmds+=("Python" "mise install python; mise global --pin python@latest")
fi

if ! ask_skip "Node"; then
  cmds+=("Node" "mise install node; mise global --pin node@latest")
fi

if [[ ${#cmds[@]} -ne 0 ]]; then
  echo 'Going to run all long-running installs in tmux!'
  run_in_tmux 'setup' "${cmds[@]}"
fi
