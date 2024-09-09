{
  config,
  pkgs,
  ...
}: {
  programs.zsh = {
    enable = true;
    envExtra = ''
      fpath=(~/dotfiles/zsh/completions $fpath)
    '';
  };
}
