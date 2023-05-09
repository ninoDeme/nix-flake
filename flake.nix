{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";

    home-manager.url = "github:nix-community/home-manager/release-22.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";

    emacs-overlay.url  = "github:nix-community/emacs-overlay";
  };

  outputs = inputs @ { self, nixpkgs, home-manager, emacs-overlay ,... }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
    lib = nixpkgs.lib;

  in {

    nixosConfigurations.nixos = lib.nixosSystem {
      inherit system;
      modules = [
        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
        }
        ./configuration.nix
        ./hardware/note-nvidia.nix
      ];
    };
  };
}
