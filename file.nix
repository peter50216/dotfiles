{
  config,
  lib,
  ...
}: let
  mkDotfileSymlink = path:
    config.lib.file.mkOutOfStoreSymlink
    (builtins.toString (config.home.homeDirectory + "/dotfiles/${path}"));
in {
  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # git
    ".config/git/ignore".source = ./external/gitignore_global;
    # nvim
    ".config/nvim".source = mkDotfileSymlink "external/nvim";
    # Remove the zlogout from prezto.
    ".zlogout".text = lib.mkOverride 10 "";
  };
}
