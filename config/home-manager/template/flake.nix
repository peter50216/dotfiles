let
  mkBaseConfig = import ./mkBaseConfig.nix;
in
  mkBaseConfig {
    username = "USERNAME";
    homeDirectory = "HOME_DIRECTORY";
    system = "SYSTEM";
  }
