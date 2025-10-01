{...}: {
  programs.zsh = {
    enable = true;

    # TODO(Darkpi): Some way to simplify this?
    initContent = ''
      ${builtins.readFile ./functions.zsh}
      ${builtins.readFile ./init.zsh}
    '';
    profileExtra = ''
      ${builtins.readFile ./profile.zsh}
    '';

    history = {
      size = 100000;
      save = 100000;
    };
  };
}
