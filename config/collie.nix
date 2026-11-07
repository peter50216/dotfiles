{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.dotfiles.collie;
  home = config.home.homeDirectory;
  toml = pkgs.formats.toml {};

  configDir = "${home}/.config/collie";
  stateDir = "${home}/.local/state/collie";
  origin = "https://${cfg.publicHost}";

  # Settings that the bridge and the CLI wrapper must both see. The bridge
  # does not read a .env file itself, so the unit passes this file, and the
  # CLI wrapper sources the same file.
  envVars = {
    COLLIE_HOST = "127.0.0.1";
    COLLIE_PORT = toString cfg.bridgePort;
    COLLIE_MUX = "herdr";
    HERDR_SOCKET_PATH = "${home}/.config/herdr/herdr.sock";
    HERDR_PLUGIN_CONFIG_DIR = configDir;
    COLLIE_STATE_DIR = stateDir;
    COLLIE_PLUGIN_ROOT = cfg.checkout;
    # Traefik is the front door; never run `tailscale serve`.
    COLLIE_SKIP_SERVE = "1";
    COLLIE_PUBLIC_HOSTS = cfg.publicHost;
    COLLIE_ALLOWED_ORIGINS = origin;
    COLLIE_PUBLIC_URL = origin;
    COLLIE_ACCESS_TEAM = cfg.accessTeam;
    COLLIE_ACCESS_AUD = cfg.accessAud;
    # No agent-to-agent messages, no durable programs, no skill writes into
    # ~/.claude, ~/.codex and similar after an update.
    COLLIE_WALKY = "off";
    COLLIE_PROGRAMS = "off";
    COLLIE_SKILL_SYNC = "off";
    # Usage windows: Codex only (local session files). Claude's would read the
    # OAuth token in ~/.claude/.credentials.json; the statusLine already shows
    # those numbers.
    COLLIE_ACCOUNT_WINDOWS = "codex";
    # No daily install ping to ping.colliepwa.dev (on by default since 1.27.0).
    # An env "off" also stops the phone from turning it back on.
    COLLIE_TELEMETRY = "0";
  };
  envFile = pkgs.writeText "collie.env" (lib.concatStrings (lib.mapAttrsToList (k: v: "${k}=${v}\n") envVars));

  bunOf = ''"$(${pkgs.mise}/bin/mise where bun@${cfg.bunVersion})/bin/bun"'';

  # Starts the bridge only from the audited commit with no local changes.
  # Exit status 78 stops the restart loop (RestartPreventExitStatus).
  bridge = pkgs.writeShellApplication {
    name = "collie-bridge";
    runtimeInputs = [pkgs.git pkgs.coreutils];
    text = ''
      checkout=${lib.escapeShellArg cfg.checkout}
      head=$(git -C "$checkout" rev-parse HEAD)
      if [ "$head" != ${lib.escapeShellArg cfg.rev} ]; then
        echo "collie-bridge: $checkout is at $head, not the audited commit ${cfg.rev}. Refusing to start." >&2
        exit 78
      fi
      if [ -n "$(git -C "$checkout" status --porcelain --untracked-files=no)" ]; then
        echo "collie-bridge: $checkout has local changes. Refusing to start." >&2
        exit 78
      fi
      bun=${bunOf}
      cd "$checkout"
      exec "$bun" bridge/index.ts
    '';
  };

  # The upstream CLI, limited to the commands that only read or touch the
  # state and config directories. `start`, `update`, `skill`, `crew`,
  # `hooks install` and the others write systemd units, run `tailscale
  # serve`, fetch new code or write agent config, so the wrapper refuses
  # them.
  #
  # `beacon` is the command of the Claude Code hooks in ~/.claude/settings.json
  # (entries marked `# collie-beacon v1`, written by hand because
  # `hooks install` would point them at a bin/collie that does not exist
  # here). It comes first and never fails: Claude Code treats exit status 2
  # from a UserPromptSubmit or Stop hook as "block", so any problem exits 0
  # with no output. It must `exec`, because Collie reads its parent pid.
  cli = pkgs.writeShellApplication {
    name = "collie";
    runtimeInputs = [pkgs.git pkgs.coreutils];
    text = ''
      if [ "''${1:-}" = beacon ]; then
        caller_sock="''${HERDR_SOCKET_PATH-}"
        set -a
        # shellcheck disable=SC1091
        . ${envFile} 2>/dev/null || exit 0
        set +a
        if [ -n "$caller_sock" ]; then export HERDR_SOCKET_PATH="$caller_sock"; fi
        bun_dir="$(${pkgs.mise}/bin/mise where bun@${cfg.bunVersion} 2>/dev/null)" || exit 0
        [ -x "$bun_dir/bin/bun" ] || exit 0
        exec "$bun_dir/bin/bun" ${lib.escapeShellArg "${cfg.checkout}/cli/main.ts"} "$@"
      fi
      case "''${1:-}" in
        hooks)
          case "''${2:-}" in
            status | uninstall) ;;
            *)
              echo "collie: only 'hooks status' and 'hooks uninstall' are allowed." >&2
              echo "'hooks install' writes a bin/collie path that does not exist here; see config/collie.nix." >&2
              exit 2
              ;;
          esac
          ;;
        pair | devices | doctor | push-keys | help | --help | -h | --version) ;;
        *)
          echo "collie: '$*' is not allowed by the dotfiles wrapper (config/collie.nix)." >&2
          echo "Allowed: pair, devices, doctor, push-keys, hooks status, hooks uninstall, help." >&2
          exit 2
          ;;
      esac
      set -a
      # shellcheck disable=SC1091
      . ${envFile}
      set +a
      bun=${bunOf}
      exec "$bun" ${lib.escapeShellArg "${cfg.checkout}/cli/main.ts"} "$@"
    '';
  };

  proxyRoutes = toml.generate "collie-proxy-routes.toml" {
    http = {
      routers.collie = {
        rule = "Host(`${cfg.publicHost}`)";
        entryPoints = ["collie"];
        service = "collie";
      };
      services.collie.loadBalancer = {
        passHostHeader = true;
        servers = [{url = "http://127.0.0.1:${toString cfg.bridgePort}";}];
      };
    };
  };

  proxyStatic = toml.generate "collie-proxy.toml" {
    global = {
      checkNewVersion = false;
      sendAnonymousUsage = false;
    };
    log.level = "INFO";
    entryPoints.collie =
      {address = "${cfg.listenAddress}:${toString cfg.port}";}
      // lib.optionalAttrs (cfg.trustedProxies != []) {
        forwardedHeaders.trustedIPs = cfg.trustedProxies;
      };
    providers.file.filename = "${proxyRoutes}";
  };

  launchers = toml.generate "collie-launchers.toml" ({
      phone = {
        adds = false;
        run = true;
        free_text = false;
      };
    }
    // lib.optionalAttrs (cfg.launchers != []) {launchers = cfg.launchers;});
in {
  # Collie (github.com/AltanS/collie) is a phone client for herdr. It can
  # type into every shell on this machine, so this module keeps it on
  # loopback and puts a Traefik in front of it on one tailnet address.
  #
  # Why the extra proxy: Collie lets a request skip its Cloudflare Access
  # check when the Host header is loopback and no forwarding header is
  # present. Both come from the client. On loopback only local processes
  # can connect, so that is safe. Bound to a tailnet address, any tailnet
  # node could send `Host: localhost` and skip Access. Traefik routes only
  # `publicHost` and always adds X-Forwarded-For, so no request through it
  # counts as local.
  #
  # The Collie checkout is not managed here: update it by hand after an
  # audit of the diff, then change `rev`. The Cloudflare side (Access
  # application, route on the edge) lives in the homelab-k3s repo, ticket
  # hk-7zlz. Off by default; a machine turns it on in its local.nix.
  options.dotfiles.collie = {
    enable = lib.mkEnableOption "Collie, a phone client for herdr, behind a local Traefik on one tailnet address";
    checkout = lib.mkOption {
      type = lib.types.str;
      description = "Absolute path of the Collie git checkout.";
    };
    rev = lib.mkOption {
      type = lib.types.str;
      default = "399ca0adbd06721e694261a415a646aa21278d49";
      description = "The audited Collie commit (v1.27.2). The bridge does not start from any other commit.";
    };
    bunVersion = lib.mkOption {
      type = lib.types.str;
      default = "1.4.4";
      description = "Bun version that mise provides for Collie (Collie's CI pin).";
    };
    publicHost = lib.mkOption {
      type = lib.types.str;
      description = "Public host name of this machine's Collie, for example collie-dev.chino.cafe.";
    };
    listenAddress = lib.mkOption {
      type = lib.types.str;
      description = "Address for the Traefik front: this machine's Tailscale IP.";
    };
    port = lib.mkOption {
      type = lib.types.port;
      default = 8801;
      description = "Port for the Traefik front on listenAddress.";
    };
    bridgePort = lib.mkOption {
      type = lib.types.port;
      default = 8801;
      description = "Port for the Collie bridge on 127.0.0.1.";
    };
    trustedProxies = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = "Addresses whose X-Forwarded-* headers Traefik keeps (the edge Traefik). Others get their headers replaced.";
    };
    accessTeam = lib.mkOption {
      type = lib.types.str;
      description = "Cloudflare Access team name (the part before .cloudflareaccess.com).";
    };
    accessAud = lib.mkOption {
      type = lib.types.str;
      description = "Audience tag of this host's own Access application.";
    };
    launchers = lib.mkOption {
      type = lib.types.listOf (lib.types.attrsOf lib.types.str);
      default = [];
      description = "Launcher rows for the phone: attribute sets with command, and optional label and cwd.";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [cli];

    xdg.configFile."collie/launchers.toml".source = launchers;

    systemd.user.services.collie = {
      Unit = {
        Description = "Collie bridge (phone client for herdr) on 127.0.0.1";
        StartLimitIntervalSec = 0;
      };
      Service = {
        Type = "simple";
        WorkingDirectory = cfg.checkout;
        # The second file wins, so a key in ~/.config/collie/.env (VAPID keys
        # from `collie push-keys`) cannot change these settings.
        EnvironmentFile = ["-${configDir}/.env" "${envFile}"];
        Environment = ["PATH=${lib.makeBinPath [pkgs.git pkgs.coreutils]}:/usr/local/bin:/usr/bin:/bin"];
        ExecStart = "${bridge}/bin/collie-bridge";
        Restart = "always";
        RestartSec = 5;
        RestartPreventExitStatus = 78;
        NoNewPrivileges = true;
        PrivateTmp = true;
      };
      Install.WantedBy = ["default.target"];
    };

    systemd.user.services.collie-proxy = {
      Unit = {
        Description = "Traefik front for Collie on ${cfg.listenAddress}:${toString cfg.port}";
        StartLimitIntervalSec = 0;
      };
      Service = {
        Type = "simple";
        ExecStart = "${pkgs.traefik}/bin/traefik --configFile=${proxyStatic}";
        Restart = "always";
        RestartSec = 5;
        NoNewPrivileges = true;
        PrivateTmp = true;
      };
      Install.WantedBy = ["default.target"];
    };
  };
}
