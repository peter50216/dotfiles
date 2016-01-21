if [[ -n "${key[PageUp]}" ]]; then
  bindkey "${key[PageUp]}" backward-word
fi
if [[ -n "${key[PageDown]}" ]]; then
  bindkey "${key[PageDown]}" forward-word
fi
