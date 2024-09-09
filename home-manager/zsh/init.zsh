setopt magic_equal_subst
setopt CLOBBER            # Don't care about overwrite existing file with > and >>.
                          # unset by modules/directory in prezto
setopt inc_append_history
unsetopt share_history    # Don't share history in multiple simutaneous zsh.
                          # set by modules/history in prezto

# No Ctrl+S freezing in vim.
stty -ixon

if [[ -n "${terminfo[kpp]}" ]]; then
  bindkey "${terminfo[kpp]}" backward-word
fi
if [[ -n "${terminfo[knp]}" ]]; then
  bindkey "${terminfo[knp]}" forward-word
fi

# From: https://hackerfall.com/story/how-to-boost-your-vim-productivity
fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line
  else
    zle push-input
    zle clear-screen
  fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z

# TODO(Darkpi): Consider remove this when all local config moves to nix
# too.
if [[ -f ~/.zshrc_local ]]; then
  source ~/.zshrc_local
fi
