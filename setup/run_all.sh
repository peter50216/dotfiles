#!/bin/bash
set -e

source setup/utils.sh

./setup/essentials.sh
ask_skip 'useful tools setup' || ./setup/tools.sh
