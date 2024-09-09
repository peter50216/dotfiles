{
  config,
  pkgs,
  ...
}: {
  programs.zsh.prezto = {
    enable = true;

    # IMPORTANT: Do not change order of last six
    #   (utility, completion, prompt, syntax-highlighting,
    #    history-substring-search, autosuggestions)
    #   and the first one.
    pmodules = [
      "environment"
      "command-not-found"
      "directory"
      "editor"
      "git"
      "history"
      "spectrum"
      "terminal"
      "utility"
      "completion"
      "prompt"
      "syntax-highlighting"
      "history-substring-search"
      "autosuggestions"
    ];
    syntaxHighlighting.highlighters = [
      "main"
      "brackets"
    ];
    ssh.identities = ["id_rsa"];
    prompt.theme = "pure";

    # Makes "gws" much faster
    git.submoduleIgnore = "dirty";

    extraConfig = ''
      # Solve completion takes too long.
      zstyle ':completion:*' users pihsun root
    '';
  };
}
