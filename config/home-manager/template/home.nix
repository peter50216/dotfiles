{
  config,
  pkgs,
  specialArgs,
  ...
}: let
  inherit (specialArgs) system username homeDirectory;
in {
  home.packages = with pkgs; [
  ];

  home.file = {
  };

  home.sessionVariables = {
  };
}
