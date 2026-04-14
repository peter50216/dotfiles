{
  sources ? import ./npins,
  system ? builtins.currentSystem,
  stagedPackages ? builtins.fromJSON (builtins.readFile ./upgrade/staged-packages.json),
  pkgsNextRaw ? import sources."nixpkgs-next" {inherit system;},
  pkgs ? import sources.nixpkgs {
    inherit system;
    # Keep the default package set on nixpkgs and selectively replace staged
    # top-level packages with the nixpkgs-next version.
    overlays = [
      (
        final: prev:
          builtins.listToAttrs (map (name: {
            inherit name;
            value = builtins.getAttr name pkgsNextRaw;
          }) stagedPackages)
      )
    ];
  },
  nixGL ? import sources.nixGL {inherit pkgs;},
}: let
  configuration = import ./home.nix;
  hm = import "${sources.home-manager}/modules" {
    inherit pkgs configuration;
    extraSpecialArgs = {inherit nixGL;};
  };
in
  pkgs.writeShellApplication {
    name = "switch";
    text = "${hm.activationPackage}/activate";
  }
