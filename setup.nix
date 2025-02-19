{lib, ...}: {
  home.activation = {
    runSetup = lib.hm.dag.entryAfter ["writeBoundary"] ''
      if [[ -f "$HOME/.setup-done" ]]; then
        verboseEcho "Setup has already been run. Skipping..."
      else
        verboseEcho "Running one-time setup..."

        if [ ! -f ~/.gitconfig ]; then
          if grep -q GOOGLE /etc/lsb-release 2>/dev/null; then
            run cp ~/dotfiles/external/gitconfig_defaults/google ~/.gitconfig
          else
            run cp ~/dotfiles/external/gitconfig_defaults/public ~/.gitconfig
          fi
        fi

        run touch "$HOME/.setup-done"
        verboseEcho "Setup completed successfully!"
      fi
    '';
    # TODO: Somehow automate chsh zsh
  };
}
