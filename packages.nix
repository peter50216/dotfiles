{pkgs, ...}: {
  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    dua
    gnumake
    git-lfs
    hyperfine
    neovim
    nil
    npins
    shellcheck
    usage
    unixtools.xxd
    bubblewrap
    (pkgs.callPackage ./packages/rgr.nix {})
    (pkgs.callPackage ./packages/unarchive.nix {})
  ];

  programs = {
    bat.enable = true;
    broot.enable = true;
    btop.enable = true;
    eza.enable = true;
    fd.enable = true;
    fzf.enable = true;
    htop.enable = true;
    jq.enable = true;
    mise = {
      enable = true;
      package = pkgs.mise;
    };
    ripgrep.enable = true;
    zoxide = {
      enable = true;
      # Disable zsh integration and doing it manually in init.zsh, to
      # workaround a Claude Code issue:
      # https://github.com/anthropics/claude-code/issues/2632
      enableZshIntegration = false;
    };

    # Let Home Manager install and manage itself.
    home-manager.enable = true;
  };
}
