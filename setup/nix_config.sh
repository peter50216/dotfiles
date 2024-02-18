#!/bin/bash

sed "s#USERNAME#$USER#g; s#HOME_DIRECTORY#$HOME#g; s#SYSTEM#$(uname -m)-linux#g" ./config/home-manager/template/flake.nix > ~/.config/home-manager/flake.nix
sed "s#USERNAME#$USER#g; s#HOME_DIRECTORY#$HOME#g; s#SYSTEM#$(uname -m)-linux#g" ./config/home-manager/template/home.nix > ~/.config/home-manager/home.nix
