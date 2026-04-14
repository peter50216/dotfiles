setopt magic_equal_subst
setopt CLOBBER # Don't care about overwrite existing file with > and >>.
# unset by modules/directory in prezto
setopt inc_append_history
unsetopt share_history # Don't share history in multiple simutaneous zsh.
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
fancy-ctrl-z() {
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

# Workaround for https://github.com/anthropics/claude-code/issues/2632
# Disable zoxide when running under Claude Code to avoid shell function conflicts
if command -v zoxide &>/dev/null && [[ "$CLAUDECODE" != "1" ]]; then
  eval "$(zoxide init --cmd cd zsh)"
fi

function _dotfiles_hm_upgrade_maybe_remind() {
  command -v jq &>/dev/null || return

  local repo_root="$HOME/dotfiles"
  local sources_file="$repo_root/npins/sources.json"
  local staged_file="$repo_root/upgrade/staged-packages.json"

  [[ -f "$sources_file" && -f "$staged_file" ]] || return

  if ! jq -e '.pins.nixpkgs != .pins["nixpkgs-next"]' "$sources_file" >/dev/null && ! jq -e 'length > 0' "$staged_file" >/dev/null; then
    return
  fi

  local cache_dir="$HOME/.cache/dotfiles"
  local stamp_file="$cache_dir/hm-upgrade-reminder-date"
  local today staged_summary
  today="$(date +%F)"

  mkdir -p "$cache_dir"
  if [[ -f "$stamp_file" && "$(<"$stamp_file")" == "$today" ]]; then
    return
  fi

  print -r -- "$today" >! "$stamp_file"
  staged_summary="$(jq -r 'if length == 0 then "(none)" else join(", ") end' "$staged_file")"

  print
  print "nixpkgs staged upgrade in progress:"
  print "  staged packages: $staged_summary"
  print "  run: hm-upgrade-status"
}

_dotfiles_hm_upgrade_maybe_remind

# TODO(Darkpi): Consider remove this when all local config moves to nix
# too.
if [[ -f ~/.zshrc_local ]]; then
  source ~/.zshrc_local
fi
