{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.dotfiles.chromeReaper;
  reaper = pkgs.writeShellApplication {
    name = "chrome-reaper";
    runtimeInputs = with pkgs; [coreutils gawk gnugrep iproute2 procps];
    text = builtins.readFile ./chrome-reaper.sh;
  };
in {
  # Off by default: stopping processes on a schedule is a per-machine decision, so a machine
  # turns it on in its local.nix with `dotfiles.chromeReaper.enable = true;`.
  options.dotfiles.chromeReaper = {
    enable = lib.mkEnableOption "an hourly user timer that stops headless Chrome its launcher abandoned (see chrome-reaper.sh)";
    minAgeMinutes = lib.mkOption {
      type = lib.types.ints.positive;
      default = 360;
      description = "Minimum age before an orphaned, idle headless Chrome is stopped.";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [reaper];

    systemd.user.services.chrome-reaper = {
      Unit.Description = "Stop headless Chrome its launcher abandoned";
      Service = {
        Type = "oneshot";
        ExecStart = "${reaper}/bin/chrome-reaper";
        Environment = ["CHROME_REAPER_MIN_AGE_MIN=${toString cfg.minAgeMinutes}"];
      };
    };

    systemd.user.timers.chrome-reaper = {
      Unit.Description = "Run chrome-reaper hourly";
      Timer.OnCalendar = "hourly";
      Install.WantedBy = ["timers.target"];
    };
  };
}
