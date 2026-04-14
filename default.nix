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
  configuration = {lib, ...}: {
    imports = [./home.nix];

    # Home Manager rebuilds _module.args.pkgs from pkgsPath/config.nixpkgs
    # unless we force the package set we already constructed here.
    _module.args.pkgs = lib.mkForce pkgs;
  };
  hm = import "${sources.home-manager}/modules" {
    inherit pkgs configuration;
    extraSpecialArgs = {inherit nixGL;};
  };
in
  pkgs.writeShellApplication {
    name = "switch";
    text = "${hm.activationPackage}/activate";
  }
