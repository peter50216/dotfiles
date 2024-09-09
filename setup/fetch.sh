if ! sudo -l >/dev/null 2>&1; then
  echo $'\e[1;31mIt appears that you can\'t sudo, but installing nix & git needs sudo privilege...\e[m'
  exit 1
fi
if ! command -v git >/dev/null 2>&1; then
  echo $'\e[1;33mgit not installed, installing...\e[m'
  sudo apt-get update
  sudo apt-get -y install git
fi
git clone --filter=blob:none https://github.com/peter50216/dotfiles ~/dotfiles
cd ~/dotfiles
git remote set-url --push origin git@github.com:peter50216/dotfiles.git
./setup/install.sh
