# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi
# zplug "b4b4r07/zplug"

# # pure-prompt
# zplug "mafredri/zsh-async"
# zplug "sindresorhus/pure"

# # zsh-syntax-highlighting
# ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
# zplug "zsh-users/zsh-syntax-highlighting", nice:10

# # oh-my-zsh
# # options
# DISABLE_AUTO_TITLE="true"
# COMPLETION_WAITING_DOTS="true"
# ZSH_TMUX_AUTOCONNECT="false"
# BUNDLED_COMMANDS=(passenger padrino)

# # plugins
# plugins=(ssh-agent tmux git gitignore \
  # bundler rbenv ruby gem \
  # pip pyenv python \
  # node golang vagrant)
# for p in "${plugins[@]}"; do
  # zplug "plugins/$p", from:oh-my-zsh
# done

# if ! zplug check --verbose; then
  # zplug install
# fi
# zplug load --verbose
