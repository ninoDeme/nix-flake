{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/release-23.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";

    emacs-overlay.url  = "github:nix-community/emacs-overlay";
  };

  outputs = inputs @ { self, nixpkgs, nixpkgs-unstable, home-manager, emacs-overlay ,... }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
    pkgs-unstable = import nixpkgs-unstable {
      inherit system;
      config.allowUnfree = true;
    };
    lib = nixpkgs.lib;

  in {

    overlay = final: prev: {
      unstable = pkgs-unstable;
    };

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
