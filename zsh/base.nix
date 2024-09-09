{
  config,
  pkgs,
  ...
}: {
  programs.zsh = {
    enable = true;

    # TODO(Darkpi): Some way to simplify this?
    initExtra = ''
      ${builtins.readFile ./functions/spectrum_ls.zsh}
      ${builtins.readFile ./functions/pipis.zsh}
      ${builtins.readFile ./init.zsh}
    '';

    history = {
      size = 100000;
      save = 100000;
    };
  };
}
