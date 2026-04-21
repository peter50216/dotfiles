let
  hmSessionVars = builtins.readFile ./hm-session-vars.zsh;
in {
  programs.zsh = {
    enable = true;

    # TODO(Darkpi): Some way to simplify this?
    initContent = ''
      ${hmSessionVars}
      ${builtins.readFile ./functions.zsh}
      ${builtins.readFile ./init.zsh}
    '';
    profileExtra = ''
      ${hmSessionVars}
      ${builtins.readFile ./profile.zsh}
    '';

    history = {
      size = 100000;
      save = 100000;
    };
  };
}
