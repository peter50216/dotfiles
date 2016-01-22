#!/bin/bash

./setup/essentials.sh
ask_skip 'useful tools setup' || ./setup/tools.sh
