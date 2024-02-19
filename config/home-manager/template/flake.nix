{
  description = "Home Manager configuration of darkpi";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    ...
  }: let
    username = "USERNAME";
    homeDirectory = "HOME_DIRECTORY";
    system = "SYSTEM";
  in {
    homeConfigurations = let
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      ${username} = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [
          ./home.nix
          ./common
        ];

        extraSpecialArgs = {
          inherit system username homeDirectory;
        };
        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
      };
    };
  };
}
