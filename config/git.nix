{...}: {
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

    # Workaround bugs for old aider version. See
    # https://github.com/Aider-AI/aider/issues/1085
    # TODO: remove this when all machines have aider updated.
    userName = "";

    userEmail = "";

    # Many of these are from
    # https://blog.gitbutler.com/how-git-core-devs-configure-git/
    extraConfig = {
      branch.sort = "-committerdate";

      color.ui = true;

      column.ui = "auto";

      core = {
        abbrev = 12;
        commitGraph = true;
        editor = "nvim";
        fsmonitor = true;
        untrackedCache = true;
      };

      diff = {
        algorithm = "histogram";
        colorMoved = "plain";
        mnemonicPrefix = true;
        renames = true;
      };

      fetch = {
        prune = true;
        pruneTags = true;
        all = true;
      };

      init.defaultBranch = "main";

      pretty.fixes = "Fixes: %h (\"%s\")";

      push = {
        default = "simple";
        autoSetupRemote = true;
        followTags = true;
      };

      rebase = {
        autoSquash = true;
        autoStash = true;
        updateRefs = true;
      };

      tag.sort = "version:refname";
    };
  };
}
