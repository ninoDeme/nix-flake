{ config, lib, pkgs, ... }:

with lib;
{
  options.modules.desktops.i3 = mkOption {
    default = false;
    type = types.bool;
  };
  config = mkIf config.modules.desktops.i3 {

    services.xserver.windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
    };

  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "Noto" ]; })
  ];
    environment.systemPackages = with pkgs; [
      dmenu #application launcher most people use
      i3status # gives you the default i3 status bar
      i3lock #default i3 screen locker
      xterm
      xss-lock
      sxhkd
      dunst
      kitty
      rofi
      nitrogen
      picom
      lxappearance
      networkmanagerapplet
    ];

    home-manager.users.nino = {

      home.packages = with pkgs; [
      ];

    };
  };
}
