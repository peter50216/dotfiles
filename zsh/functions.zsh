function pipis() {
  pip install $1 && pip freeze | grep $1 >>requirements.txt
}

# copied from oh-my-zsh spectrum plugin
ZSH_SPECTRUM_TEXT=${ZSH_SPECTRUM_TEXT:-Arma virumque cano Troiae qui primus ab oris}

# Show all 256 colors with color number
function spectrum_ls() {
  for code in {0..255}; do
    print -P -- "$code: %{$FG[$code]%}$ZSH_SPECTRUM_TEXT%{$FX[none]%}"
  done
}

# Show all 256 colors where the background is set to specific color
function spectrum_bls() {
  for code in {0..255}; do
    print -P -- "$code: %{$BG[$code]%}$ZSH_SPECTRUM_TEXT%{$FX[none]%}"
  done
}

function hm-switch() {
  nix-build -o $HOME/dotfiles/result $HOME/dotfiles && $HOME/dotfiles/result/bin/switch && rehash
}
