{
  config,
  lib,
  ...
}: let
  mise = "${config.programs.mise.package}/bin/mise";
in {
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

    ensureMiseConfig = lib.hm.dag.entryAfter ["linkGeneration"] ''
      mise_config="$HOME/.config/mise/config.toml"
      if [[ ! -e "$mise_config" && ! -L "$mise_config" ]]; then
        verboseEcho "Creating empty user-owned mise config..."
        run mkdir -p "$HOME/.config/mise"
        run touch "$mise_config"
      fi
    '';

    installMiseTools = lib.hm.dag.entryAfter ["ensureMiseConfig"] ''
      verboseEcho "Installing mise global packages..."
      run ${mise} install --yes -C "$HOME"
    '';

    initDotfilesJj = lib.hm.dag.entryAfter ["installMiseTools"] ''
      repo_dir="$HOME/dotfiles"
      if [[ ! -d "$repo_dir/.jj" && -d "$repo_dir/.git" ]]; then
        verboseEcho "Initializing dotfiles jj repository..."
        run ${mise} exec -C "$HOME" jujutsu -- jj git init --colocate "$repo_dir"
      fi
    '';
  };
}
