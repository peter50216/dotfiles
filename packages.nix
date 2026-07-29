{pkgs, ...}: {
  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    nil
    npins
    gnumake
    unixtools.xxd
    bubblewrap
    tree-sitter
    (callPackage ./packages/ticket.nix {})
  ];

  programs = {
    htop.enable = true;
    mise = {
      enable = true;
      package = pkgs.mise;
    };

    # Let Home Manager install and manage itself.
    home-manager.enable = true;
  };
}
