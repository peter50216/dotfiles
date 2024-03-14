alias ta='tmux at -t'
alias tl='tmux ls'

alias rb='ruby'
alias py='python'
alias reboot='echo "no"'

alias glr="git reflog --format='%C(auto)%h %<(9)%gd %C(blue)%ci%C(reset) %s'"
alias gcp="git cherry-pick"

alias gbl="git branch -v --sort=-committerdate"

alias gwdd='GIT_EXTERNAL_DIFF=difft gwd --ext-diff'
alias gidd='GIT_EXTERNAL_DIFF=difft gid --ext-diff'
alias gsdd='GIT_EXTERNAL_DIFF=difft gsd --ext-diff'
alias gldd='GIT_EXTERNAL_DIFF=difft gld --ext-diff'

alias .j='just --justfile ~/.user.justfile --working-directory .'
alias fd='noglob fd'

alias vi='nvim'
alias ls='eza'

alias catp='bat -pp'
alias cat='bat'
alias cd='z'

# From rsync prezto module, without the version detection to be much faster.
_rsync_cmd='rsync --verbose --progress --human-readable --compress --archive \
  --hard-links --one-file-system --acls --xattrs'

alias rsync-copy="${_rsync_cmd}"
alias rsync-move="${_rsync_cmd} --remove-source-files"
alias rsync-update="${_rsync_cmd} --update"
alias rsync-synchronize="${_rsync_cmd} --update --delete"

unset _rsync_cmd

alias hm-switch='home-manager switch --impure; rehash'
