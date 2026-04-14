{lib, ...}: {
  home.activation = {
    migrateMiseConfig = lib.hm.dag.entryAfter ["linkGeneration"] ''
      mise_config="$HOME/.config/mise/config.toml"

      if [[ ! -e "$mise_config" && -v oldGenPath ]]; then
        old_mise_config="$oldGenPath/home-files/.config/mise/config.toml"
        old_mise_target="$(readlink -f "$old_mise_config" 2>/dev/null || true)"

        if [[ "$old_mise_target" == /nix/store/*-mise-config ]]; then
          verboseEcho "Migrating Home Manager-managed mise config to a user-owned file..."
          run mkdir -p "$HOME/.config/mise"
          run cp "$old_mise_target" "$mise_config"
        fi
      fi
    '';

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

    seedMiseConfig = lib.hm.dag.entryAfter ["migrateMiseConfig"] ''
      if [[ ! -f "$HOME/.config/mise/config.toml" ]]; then
        verboseEcho "Seeding ~/.config/mise/config.toml from dotfiles template..."
        run mkdir -p "$HOME/.config/mise"
        run cp ~/dotfiles/template/mise-config.toml "$HOME/.config/mise/config.toml"
      fi
    '';
    # TODO: Somehow automate chsh zsh
  };
}
