#!/bin/bash
set -e

sed "s#USERNAME#$USER#g; s#HOME_DIRECTORY#$HOME#g; s#SYSTEM#$(uname -m)-linux#g" ./home-manager/template/home.nix > ./home-manager/home.nix
sed "s#USERNAME#$USER#g; s#HOME_DIRECTORY#$HOME#g; s#SYSTEM#$(uname -m)-linux#g" ./home-manager/template/local.nix > ./home-manager/local.nix
