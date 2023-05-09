{ config, lib, pkgs, inputs, ... }:

{
  options.modules.programming.nix = lib.mkOption {
    default = false;
    type = lib.types.bool;
  };

  config = lib.mkIf config.modules.programming.nix {

    home-manager.users.nino = {config, lib, pkgs,... }: {

      home.stateVersion = "22.11";
      # nixpkgs.overlays = [ inputs.emacs-overlay.overlay ];

      home.packages = with pkgs; [
        nil
      ];
    };
  };
}
