#!/bin/bash

if [[ ! -f ~/.dotfiles/.setup ]]; then
  echo -e '\e[1;33mFirst time setup! Make sure we have everything installed...\e[m'
  pushd ~/.dotfiles/
    ./setup/run_all.sh
    ret=$?
  popd
  if [[ $ret == 0 ]]; then
    touch ~/.dotfiles/.setup
    echo -e '\e[1;33mFirst time setup complete! Delete ~/.dotfiles/.setup and ~/.dotfiles/setup/main.sh to run again.\e[m'
  else
    echo -e '\e[1;31mFirst time setup fail QQ\e[m'
    exit 1
  fi
fi
