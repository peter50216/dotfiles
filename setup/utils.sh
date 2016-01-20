function ask_skip {
  local name=$1
  local time=${2:-5}
  read -t $time -p $'Hit ENTER to skip \e[1;37m'"$name"$'\e[m or wait '"$time"$' seconds'
}
