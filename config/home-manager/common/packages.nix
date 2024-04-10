{
  config,
  pkgs,
  specialArgs,
  inputs,
  ...
}: let
  inherit (specialArgs) system username homeDirectory;
in {
  # The home.packages option allows you to install Nix packages into your
  # environment.
  # TODO(Darkpi): Currently zsh is not managed by nix so zsh completion of
  # programs installed by nix isn't available natively. We still use
  # zsh/completions for those. Try to move to managed zsh and remove the
  # completion file.
  home.packages = with pkgs; [
    bat
    broot
    btop
    cheat
    delta
    difftastic
    dua
    eza
    fd
    git
    htop
    hyperfine
    jq
    just
    mise
    neovim
    ripgrep
    tmux
    sd
    zoxide
    zsh
    # TODO(Darkpi): mise, probably want to move that to nix too???

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
    (pkgs.callPackage ./tmux-mem-cpu-load.nix {})
  ];

  programs.atuin = {
    enable = true;
    settings = {
      filter_mode_shell_up_key_binding = "session";
      enter_accept = true;
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
