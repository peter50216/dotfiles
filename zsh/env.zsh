export WECHALLUSER="peter50216"
export WECHALLTOKEN="C03C8-2EC56-699E9-B4004-8AB5F-D50AB"

export PATH=$HOME/bin:$PATH

if [[ -d $HOME/.pyenv ]]; then
  export PATH=$HOME/.pyenv/shims:$HOME/.pyenv/bin:$PATH
fi
if [[ -d $HOME/.rbenv ]]; then
  export PATH=$HOME/.rbenv/shims:$HOME/.rbenv/bin:$PATH
fi
