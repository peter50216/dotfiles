# These actually isn't really accurate, but since we manually add shims to path,
# it should be fine in most case.
# Since there's no automatically rehash with each startup, it still has a little
# difference from calling rbenv init - in .zshrc, but it doesn't matter in most
# case I think?

if [[ -d ~/.pyenv ]]; then
  source ~/.pyenv/completions/pyenv.zsh
  pyenv() {
    eval "$(command pyenv init -)"
    pyenv "$@"
  }
fi

if [[ -d ~/.rbenv ]]; then
  source ~/.rbenv/completions/rbenv.zsh
  rbenv() {
    eval "$(command rbenv init -)"
    rbenv "$@"
  }
fi
