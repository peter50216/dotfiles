./setup/nix_config.sh

sh <(curl -L https://nixos.org/nix/install) --daemon --yes
nix run home-manager/master -- init --switch
