{
  pkgs,
  lib,
  ...
}: {
  home.activation = {
    runSetup = lib.hm.dag.entryAfter ["writeBoundary"] ''
      if [[ -f "$HOME/.setup-done" ]]; then
        verboseEcho "Setup has already been run. Skipping..."
        exit 0
      fi

      # Your setup commands go here
      verboseEcho "Running one-time setup..."

      if [ ! -f ~/.gitconfig_local ]; then
        if grep -q GOOGLE /etc/lsb-release 2>/dev/null; then
          run cp ~/dotfiles/external/gitconfig_defaults/google ~/.gitconfig_local
        else
          run cp ~/dotfiles/external/gitconfig_defaults/public ~/.gitconfig_local
        fi
      fi

      run touch "$HOME/.setup-done"
      verboseEcho "Setup completed successfully!"
    '';
  };
}
