#!/bin/bash
set -e

source setup/utils.sh

./setup/essentials.sh
./setup/tools.sh
./setup/nix.sh
