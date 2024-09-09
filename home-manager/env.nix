{
  config,
  pkgs,
  specialArgs,
  ...
}: {
  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/peter/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    DO_NOT_TRACK = 1;
    EDITOR = "nvim";
    VISUAL = "nvim";
    PAGER = "less";
    LANG = "en_US.UTF-8";
    # Fix for ubuntu slowness
    skip_global_compinit = 1;
  };

  home.sessionPath = [
    "$HOME/bin"
    "$HOME/bin/common"
  ];
}
