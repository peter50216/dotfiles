{...}: {
  programs.starship = {
    enable = true;
    settings = {
      character = {
        error_symbol = "[❯](red)";
        success_symbol = "[❯](purple)";
        vimcmd_symbol = "[❮](green)";
      };
      cmd_duration = {
        format = "[$duration]($style) ";
        min_time = 500;
      };
      directory = {
        truncation_length = 5;
        before_repo_root_style = "blue";
        style = "bold bright-blue";
        truncate_to_repo = false;
      };
      git_branch = {
        format = "[$branch]($style) ";
        style = "purple";
      };
      "git_commit" = {
        format = "[\\($hash$tag\\)]($style) ";
        style = "purple";
      };
      "git_state" = {
        format = "[\\($state( $progress_current/$progress_total)\\)]($style) ";
        style = "33";
      };
      "git_status" = {
        # git status is too slow T_T
        # gitstatusd workaround here is also slow on chromium T_T
        # https://github.com/starship/starship/issues/4305#issuecomment-1244916055
        disabled = true;
        conflicted = "​";
        deleted = "​";
        format = "[[(*$conflicted$modified$staged$renamed$deleted)](218) ($ahead_behind )]($style)";
        modified = "​";
        renamed = "​";
        staged = "​";
        style = "cyan";
        untracked = "";
      };
      hostname = {
        format = "[@$hostname]($style) ";
        style = "bright-black";
      };
      username = {
        format = "[$user]($style)";
        "style_user" = "bright-black";
      };
      gcloud = {
        disabled = true;
      };

      # No Nerd Fonts
      erlang = {
        symbol = "ⓔ ";
      };
      nodejs = {
        symbol = "[⬢](bold green) ";
      };
      pulumi = {
        symbol = "🧊 ";
      };
      typst = {
        symbol = "t ";
      };

      # Edited from Bracketed Segments Preset
      aws = {
        format = "[$symbol($profile)(\\($region\\))(\\[$duration\\])]($style) ";
      };
      bun = {
        format = "[$symbol($version)]($style) ";
      };
      c = {
        format = "[$symbol($version(-$name))]($style) ";
      };
      cmake = {
        format = "[$symbol($version)]($style) ";
      };
      cobol = {
        format = "[$symbol($version)]($style) ";
      };
      conda = {
        format = "[$symbol$environment]($style) ";
      };
      crystal = {
        format = "[$symbol($version)]($style) ";
      };
      daml = {
        format = "[$symbol($version)]($style) ";
      };
      dart = {
        format = "[$symbol($version)]($style) ";
      };
      deno = {
        format = "[$symbol($version)]($style) ";
      };
      docker_context = {
        format = "[$symbol$context]($style) ";
      };
      dotnet = {
        format = "[$symbol($version)(🎯 $tfm)]($style) ";
      };
      elixir = {
        format = "[$symbol($version \\(OTP $otp_version\\))]($style) ";
      };
      elm = {
        format = "[$symbol($version)]($style) ";
      };
      erlang = {
        format = "[$symbol($version)]($style) ";
      };
      fennel = {
        format = "[$symbol($version)]($style) ";
      };
      fossil_branch = {
        format = "[$symbol$branch]($style) ";
      };
      gcloud = {
        format = "[$symbol$account(@$domain)(\\($region\\))]($style) ";
      };
      golang = {
        format = "[$symbol($version)]($style) ";
      };
      gradle = {
        format = "[$symbol($version)]($style) ";
      };
      guix_shell = {
        format = "[$symbol]($style) ";
      };
      haskell = {
        format = "[$symbol($version)]($style) ";
      };
      haxe = {
        format = "[$symbol($version)]($style) ";
      };
      helm = {
        format = "[$symbol($version)]($style) ";
      };
      hg_branch = {
        format = "[$symbol$branch]($style) ";
      };
      java = {
        format = "[$symbol($version)]($style) ";
      };
      julia = {
        format = "[$symbol($version)]($style) ";
      };
      kotlin = {
        format = "[$symbol($version)]($style) ";
      };
      kubernetes = {
        format = "[$symbol$context( \\($namespace\\))]($style) ";
      };
      lua = {
        format = "[$symbol($version)]($style) ";
      };
      memory_usage = {
        format = "$symbol[$ram( | $swap)]($style) ";
      };
      meson = {
        format = "[$symbol$project]($style) ";
      };
      nim = {
        format = "[$symbol($version)]($style) ";
      };
      nix_shell = {
        format = "[$symbol$state( \\($name\\))]($style) ";
      };
      nodejs = {
        format = "[$symbol($version)]($style) ";
      };
      ocaml = {
        format = "[$symbol($version)(\\($switch_indicator$switch_name\\))]($style) ";
      };
      opa = {
        format = "[$symbol($version)]($style) ";
      };
      openstack = {
        format = "[$symbol$cloud(\\($project\\))]($style) ";
      };
      os = {
        format = "[$symbol]($style) ";
      };
      package = {
        format = "[$symbol$version]($style) ";
      };
      perl = {
        format = "[$symbol($version)]($style) ";
      };
      php = {
        format = "[$symbol($version)]($style) ";
      };
      pijul_channel = {
        format = "[$symbol$channel]($style) ";
      };
      pulumi = {
        format = "[$symbol$stack]($style) ";
      };
      purescript = {
        format = "[$symbol($version)]($style) ";
      };
      python = {
        format = "[$symbol$pyenv_prefix($version)(\\($virtualenv\\))]($style) ";
      };
      raku = {
        format = "[$symbol($version-$vm_version)]($style) ";
      };
      red = {
        format = "[$symbol($version)]($style) ";
      };
      ruby = {
        format = "[$symbol($version)]($style) ";
      };
      rust = {
        format = "[$symbol($version)]($style) ";
      };
      scala = {
        format = "[$symbol($version)]($style) ";
      };
      solidity = {
        format = "[$symbol($version)]($style) ";
      };
      spack = {
        format = "[$symbol$environment]($style) ";
      };
      sudo = {
        format = "[as $symbol]($style) ";
      };
      swift = {
        format = "[$symbol($version)]($style) ";
      };
      terraform = {
        format = "[$symbol$workspace]($style) ";
      };
      time = {
        format = "[$time]($style) ";
      };
      vagrant = {
        format = "[$symbol($version)]($style) ";
      };
      vlang = {
        format = "[$symbol($version)]($style) ";
      };
      zig = {
        format = "[$symbol($version)]($style) ";
      };
    };
  };
}
