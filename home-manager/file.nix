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
    # git
    ".gitignore_global".source = ./external/gitignore_global;
    # # vim
    # ".local/share/nvim/site/autoload/plug.vim".source = mkDotfileSymlink "modules/vim-plug/plug.vim";
    #
    # # nvim
    # ".config/nvim".source = mkDotfileSymlink "config/nvim";
  };
}
