{...}: {
  programs.starship = {
    enable = true;
    settings = {
      character = {
        "error_symbol" = "[❯](red)";
        "success_symbol" = "[❯](purple)";
        "vimcmd_symbol" = "[❮](green)";
      };
      "cmd_duration" = {
        format = "[$duration]($style)";
        min_time = 500;
      };
      directory = {
        "repo_root_style" = "bold bright-blue";
        style = "blue";
        "truncate_to_repo" = false;
      };
      "git_branch" = {
        format = "[$branch]($style)";
        style = "purple";
      };
      "git_state" = {
        format = "\\([$state( $progress_current/$progress_total)]($style)\\) ";
        style = "bright-black";
      };
      "git_status" = {
        conflicted = "​";
        deleted = "​";
        format = "[[(*$conflicted$untracked$modified$staged$renamed$deleted)](218)($ahead_behind$stashed) ]($style)";
        modified = "​";
        renamed = "​";
        staged = "​";
        stashed = "≡";
        style = "cyan";
        untracked = "​";
      };
      hostname = {
        format = "[@$hostname]($style) ";
        style = "bright-black";
      };
      username = {
        format = "[$user]($style)";
        "style_user" = "bright-black";
      };
    };
  };
}
