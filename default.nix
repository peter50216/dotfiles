{
  sources ? import ./npins,
  system ? builtins.currentSystem,
  pkgs ? import sources.nixpkgs {inherit system;},
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
