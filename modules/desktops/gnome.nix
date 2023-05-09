{ config, lib, pkgs, ... }:

with lib;
{
  options.modules.desktops.gnome = mkOption {
    default = false;
    type = types.bool;
  };
  config = mkIf config.modules.desktops.gnome {

    # Enable the GNOME Desktop Environment.
    services.xserver.displayManager.gdm.enable = true;
    services.xserver.desktopManager.gnome = {
      enable = true;
    };

    # services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];

    environment.systemPackages = with pkgs; [
      gnome.gnome-tweaks
      gnome.dconf-editor
      gnome.file-roller
    ];

    programs.dconf.enable = true;

    home-manager.users.nino = {

      home.packages = with pkgs; [
        gnomeExtensions.dash-to-dock
        gnomeExtensions.appindicator
      ];

      dconf.settings = {
        "org/gnome/desktop" = {
          "wm/preferences/button-layout" = "appmenu:minimize,maximize,close";
          "interface/show-battery-percentage" = true;
          "interface/enable-hot-corners" = false;
        };

        "org/gnome/desktop/peripherals/touchpad" = {
          click-method = "areas";
          tap-to-click = true;
          two-finger-scrolling-enabled = true;
        };

        "org/gnome/shell" = {
          disable-user-extensions = false;
          # `gnome-extensions list` for a list
          enabled-extensions = [
            "appindicatorsupport@rgcjonas.gmail.com"
            "dash-to-dock@micxgx.gmail.com"
          ];
        };
        "org/gnome/shell/extensions/dash-to-dock" = {
          apply-custom-theme = true;
          click-action = "minimize-or-previews";
        };
      };

    };
  };
}
