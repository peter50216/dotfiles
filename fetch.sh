# TODO(Darkpi): Move these checks (except git) to install script?
if ! command -v apt-get >/dev/null 2>&1; then
  echo $'\e[1;31mNo apt-get?!\e[m'
  exit 1
fi
# XXX(Darkpi): Do we really want this?
if ! sudo -l >/dev/null 2>&1; then
  echo $'\e[1;31mIt appears that you can\'t sudo, but the script assumes sudo privilege in lots of place...\e[m'
  exit 1
fi
if ! command -v git >/dev/null 2>&1; then
  echo $'\e[1;33mgit not installed, installing...\e[m'
  sudo apt-get update
  sudo apt-get -y install git
fi
git clone https://github.com/peter50216/dotfiles ~/dotfiles
~/dotfiles/install
