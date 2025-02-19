{pkgs, ...}: {
  programs.git = {
    enable = true;

    delta = {
      enable = true;

      options = {
        features = "line-numbers";
        syntax-theme = "Monokai Extended";
        file-style = "221";
        file-decoration-style = "221 ol ul";
        hunk-header-decoration-style = "243 box ul";
        line-numbers-minus-style = "167";
        line-numbers-plus-style = "114";
        line-numbers-left-style = "243";
        line-numbers-right-style = "243";
        line-numbers-right-format = "{np:^4}⋮";
        file-modified-label = "modified:";
        plus-style = "syntax \"#002000\"";
        minus-style = "syntax \"#280000\"";
      };
    };

    userName = "";

    userEmail = "";

    extraConfig = {
      core = {
        editor = "nvim";
        excludesfile = "~/.gitignore_global";
        abbrev = 12;
        commitGraph = true;
        untrackedCache = true;
        fsmonitor = true;
      };

      color.ui = true;

      push.default = "current";

      pretty.fixes = "Fixes: %h (\"%s\")";

      init.defaultBranch = "main";

      rebase.autoSquash = true;
    };
  };
}
