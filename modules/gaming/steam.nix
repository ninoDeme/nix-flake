{ config, lib, pkgs, inputs, ... }:

{
  options.modules.gaming.steam = lib.mkOption {
    default = false;
    type = lib.types.bool;
  };

  config = lib.mkIf config.modules.gaming.steam {

    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    };

    home-manager.users.nino = {config, lib, pkgs,... }: {

      home.stateVersion = "22.11";
      # nixpkgs.overlays = [ inputs.emacs-overlay.overlay ];

      home.packages = with pkgs; [
        steam
        steam-run
      ];
    };
  };
}
