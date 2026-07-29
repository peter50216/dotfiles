{stdenvNoCC}: let
  sources = import ../npins;
in
  stdenvNoCC.mkDerivation {
    pname = "ticket";
    version = builtins.substring 0 12 sources.ticket.revision;
    src = sources.ticket;
    # The Makefile only has a test target; there is nothing to build.
    dontBuild = true;
    installPhase = ''
      runHook preInstall
      install -Dm755 ticket $out/bin/tk
      cp -a plugins/ticket-* $out/bin/
      runHook postInstall
    '';
  }
