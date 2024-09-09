{pkgs, ...}: {
  home.packages = [
    (pkgs.callPackage ../packages/tmux-mem-cpu-load.nix {})
  ];

  programs.tmux = {
    enable = true;
    escapeTime = 0;
    keyMode = "vi";
    shortcut = "a";
    shell = "${pkgs.zsh}/bin/zsh";
    terminal = "screen-256color";
    extraConfig = builtins.readFile ../external/tmux.conf;
    sensibleOnTop = true;
  };
}
