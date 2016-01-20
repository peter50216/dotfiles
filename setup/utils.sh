function ask_skip {
  local name=$1
  local time=${2:-5}
  read -t $time -p $'Hit ENTER to skip \e[1;37m'"$name"$'\e[m or wait '"$time"$' seconds\n'
}

function run_in_tmux {
  local session_name=$1; shift
  local name=$1; shift
  local cmd=$1; shift
  tmux new-session -d -n "$name" -s "$session_name" "($cmd) || (echo -e \"\e[1;33mCommand fail QQ\e[m\"; $SHELL)"
  while [[ $# -ne 0 ]]; do
    name=$1; shift
    cmd=$1; shift
    tmux new-window -n "$name" "($cmd) || (echo -e \"\e[1;33mCommand fail QQ\e[m\"; $SHELL)"
  done
  tmux attach-session
}
