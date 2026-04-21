{lib, ...}: {
  home.activation = {
    seedGitconfig = lib.hm.dag.entryAfter ["writeBoundary"] ''
      if [[ ! -f "$HOME/.gitconfig" ]]; then
        verboseEcho "Seeding ~/.gitconfig from dotfiles defaults..."
        if grep -q GOOGLE /etc/lsb-release 2>/dev/null; then
          run cp ~/dotfiles/external/gitconfig_defaults/google ~/.gitconfig
        else
          run cp ~/dotfiles/external/gitconfig_defaults/public ~/.gitconfig
        fi
      fi
    '';
  };
}
