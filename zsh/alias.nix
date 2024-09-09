{
  config,
  pkgs,
  ...
}: {
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
      ".j" = "just --justfile ~/.user.justfile --working-directory .";
      fd = "noglob fd";
      vi = "nvim";
      ls = "eza";
      catp = "bat -pp";
      cat = "bat";
      cd = "z";
      br = "broot";
      rsync-copy = rsync_cmd;
      rsync-move = "${rsync_cmd} --remove-source-files";
      rsync-update = "${rsync_cmd} --update";
      rsync-synchronize = "${rsync_cmd} --update --delete";
      hm-switch = "home-manager switch -f ~/dotfiles/home.nix; rehash";
      hm-gc = "nix-collect-garbage --delete-old";
    };
  };
}
