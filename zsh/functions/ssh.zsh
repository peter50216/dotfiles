ssh() {
  if [ "$(ps -p $(ps -p $$ -o ppid=) -o comm=)" = "tmux" ]; then
    # This actually gets current active window... (sleep 5; ssh ...) and switch
    # to another window would change wrong window title... But still this is
    # better then nothing since at least it would change the window back most of
    # the time :D
    local window_num="$(tmux display-message -p "#I")"
    tmux rename-window -t "${window_num}" -- $(echo "${@[-1]}" | cut -d ' ' -f 1)
    command ssh "$@"
    tmux set-window-option -t "${window_num}" automatic-rename "on" 1>/dev/null
  else
    command ssh "$@"
  fi
}
