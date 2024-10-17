{}: let
  sources = import ./npins;
  pkgs = import sources.nixpkgs {};
in
  pkgs.mkShell {
    packages = with pkgs; [
      alejandra
      lua-language-server
      nil
      stylua
    ];
  }
