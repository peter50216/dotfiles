{
  username,
  homeDirectory,
  system,
}: {
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
  }: {
    homeConfigurations = let
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      ${username} = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [
          ./base.nix
          ./env.nix
          ./file.nix
          ./packages.nix
          ./zsh
          ./extra.nix
        ];

        extraSpecialArgs = {
          inherit system username homeDirectory;
        };
      };
    };
  };
}
