{
  sources ? import ./npins,
  system ? builtins.currentSystem,
  pkgs ? import sources.nixpkgs {inherit system;},
}: let
  configuration = import ./home.nix;
  hm = import "${sources.home-manager}/modules" {
    inherit pkgs configuration;
  };
in
  pkgs.writeShellApplication {
    name = "switch";
    text = "${hm.activationPackage}/activate";
  }
