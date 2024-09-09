{
  config,
  pkgs,
  specialArgs,
  ...
}: let
  inherit (specialArgs) system username homeDirectory;

  dotfiles = "${homeDirectory}/dotfiles";
  mkOutSymlink = config.lib.file.mkOutOfStoreSymlink;

  # Function to create a symlink to a file in the dotfiles directory
  mkDotfileSymlink = file: mkOutSymlink "${dotfiles}/${file}";
in {
  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # TODO(Darkpi): Move most (all?) config to nix.
    # git
    # ".gitconfig".source = mkDotfileSymlink "config/gitconfig";
    # ".gitignore_global".source = mkDotfileSymlink "config/gitignore_global";

    # tmux
    # ".tmux.conf".source = mkDotfileSymlink "config/tmux.conf";
    #
    # # zsh
    # ".zlogin".source = mkDotfileSymlink "config/zlogin";
    # ".zpreztorc".source = mkDotfileSymlink "config/zpreztorc";
    # ".zprofile".source = mkDotfileSymlink "config/zprofile";
    #
    # # prezto
    # ".zprezto".source = mkDotfileSymlink "modules/prezto";
    #
    # # vim
    # ".local/share/nvim/site/autoload/plug.vim".source = mkDotfileSymlink "modules/vim-plug/plug.vim";
    #
    # # nvim
    # ".config/nvim".source = mkDotfileSymlink "config/nvim";
    #
    # # fzf
    # ".fzf".source = mkDotfileSymlink "modules/fzf";
    #
    # # nix
    # ".config/nix/nix.conf".source = mkDotfileSymlink "config/nix.conf";
    # ".config/home-manager/common".source = mkDotfileSymlink "config/home-manager/common";
    #
    # # binary
    # "bin/common".source = mkDotfileSymlink "bin";
  };
}
