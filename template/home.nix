let
  mkHome = import ./mkHome.nix;
in
  mkHome {
    username = "USERNAME";
    homeDirectory = "HOME_DIRECTORY";
  }
