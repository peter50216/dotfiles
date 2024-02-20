./setup/nix_config.sh

sh <(curl -L https://nixos.org/nix/install) --daemon --yes
source /etc/profile.d/nix.sh
nix run home-manager/master -- init --switch
