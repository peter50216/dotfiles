{...}: {
  programs.zsh = {
    shellAliases = let
      rsync_cmd = "rsync --verbose --progress --human-readable --compress --archive --hard-links --one-file-system --acls --xattrs";
    in {
      ta = "tmux at -t";
      tl = "tmux ls";
      rb = "ruby";
      py = "python";
      reboot = "echo \"no\"";
      grr = "GIT_SEQUENCE_EDITOR=: git rebase --interactive --autosquash";
      glr = "git reflog --format='%C(auto)%h %<(9)%gd %C(blue)%ci%C(reset) %s'";
      gcp = "git cherry-pick";
      gcff = "git commit --fixup";
      gbl = "git branch -v --sort=-committerdate";
      gwdd = "GIT_EXTERNAL_DIFF=difft gwd --ext-diff";
      gidd = "GIT_EXTERNAL_DIFF=difft gid --ext-diff";
      gsdd = "GIT_EXTERNAL_DIFF=difft gsd --ext-diff";
      gldd = "GIT_EXTERNAL_DIFF=difft gld --ext-diff";
      fd = "noglob fd";
      vi = "nvim";
      ls = "eza";
      catp = "bat -pp";
      cat = "bat";
      br = "broot";
      rsync-copy = rsync_cmd;
      rsync-move = "${rsync_cmd} --remove-source-files";
      rsync-update = "${rsync_cmd} --update";
      rsync-synchronize = "${rsync_cmd} --update --delete";
      hm-gc = "nix-collect-garbage --delete-old";
      "," = "MISE_TASK_DISABLE_PATHS=$HOME/.config/mise/tasks/sequence-run/node_modules mise run";
      j = "jj";
    };
  };
}
