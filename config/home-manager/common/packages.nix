{
  config,
  pkgs,
  specialArgs,
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
    btop
    cheat
    delta
    eza
    fd
    htop
    jq
    just
    mise
    neovim
    ripgrep
    zoxide
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
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
