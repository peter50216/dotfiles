source ~/.zplug/zplug
zplug "b4b4r07/zplug"

# pure-prompt
zplug "mafredri/zsh-async"
zplug "sindresorhus/pure"

# zsh-syntax-highlighting
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
zplug "zsh-users/zsh-syntax-highlighting", nice:10

if ! zplug check --verbose; then
  zplug install
fi
zplug load --verbose
