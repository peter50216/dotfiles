{pkgs, ...}: {
  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs;
    [
      cheat
      dua
      gnumake
      hyperfine
      just
      neovim
      ruby
      python3
      (pkgs.callPackage ./packages/rgr.nix {})
      (pkgs.callPackage ./packages/unarchive.nix {})
    ]
    ++ (with rubyPackages; [
      pry
    ]);

  programs = {
    bat.enable = true;
    broot.enable = true;
    btop.enable = true;
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    eza.enable = true;
    fd.enable = true;
    fzf.enable = true;
    htop.enable = true;
    jq.enable = true;
    # mise.enable = true;
    ripgrep.enable = true;
    zoxide.enable = true;

    # Let Home Manager install and manage itself.
    home-manager.enable = true;
  };
}
