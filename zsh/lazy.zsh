pyenv() {
  eval "#( command pyenv init - )"
  pyenv "$@"
}

rbenv() {
  eval "#( command rbenv init - )"
  rbenv "$@"
}
