# Do stupid fix
# We'll never use non-256-color terminal!
if [[ $TERM == "xterm" ]]; then
  export TERM=xterm-256color
fi

export WECHALLUSER="peter50216"
export WECHALLTOKEN="C03C8-2EC56-699E9-B4004-8AB5F-D50AB"

export PATH=$HOME/bin:$PATH
