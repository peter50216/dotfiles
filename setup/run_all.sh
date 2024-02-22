#!/bin/bash
set -e

source setup/utils.sh

./setup/essentials.sh
./setup/nix.sh
./setup/tools.sh
