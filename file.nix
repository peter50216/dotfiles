{config, ...}: let
  mkDotfileSymlink = path:
    config.lib.file.mkOutOfStoreSymlink
    (builtins.toString (config.home.homeDirectory + "/dotfiles/${path}"));
in {
  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # bun
    ".bunfig.toml" = {
      source = ./external/bunfig.toml;
      force = true;
    };
    # git
    ".config/git/ignore".source = ./external/gitignore_global;
    # jj
    ".config/jj/conf.d/00-dotfiles.toml".source =
      mkDotfileSymlink "external/jj/00-dotfiles.toml";
    # mise
    ".config/mise/conf.d/00-dotfiles.toml".source =
      mkDotfileSymlink "external/mise/00-dotfiles.toml";
    # nvim
    ".config/nvim".source = mkDotfileSymlink "external/nvim";
    # herdr
    ".config/herdr/config.toml".source = mkDotfileSymlink "external/herdr.toml";
    # scripts
    "bin/common".source = mkDotfileSymlink "bin";
  };
}
