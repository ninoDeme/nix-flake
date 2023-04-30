{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";
    home-manager = {
              url = "github:nix-community/home-manager/release-22.11";
              inputs.nixpkgs.follows = "nixpkgs";
    };
    dotfiles.url = "github:ninodeme/dotfiles";
    dotfiles.flake = false;
  };

  outputs = { self, nixpkgs, home-manager, dotfiles, ... }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
    lib = nixpkgs.lib;

    hmArgs = {
      inherit dotfiles;
    };
  in
  {

    nixosConfigurations.nixos = lib.nixosSystem {
      inherit system;
      modules = [
        ./configuration.nix
        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = hmArgs;
          home-manager.users.nino = {
            imports = [ ./home.nix ];
          };
        }
      ];
    };
  };
}
