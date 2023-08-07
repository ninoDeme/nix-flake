{ config, lib, pkgs, inputs, ... }:

{
  options.modules.programming.java = lib.mkOption {
    default = false;
    type = lib.types.bool;
  };

  config = lib.mkIf config.modules.programming.java {

    home-manager.users.nino = {config, lib, pkgs,... }: {

      home.stateVersion = "22.11";

      home.packages = with pkgs; [
        jdk17
        gradle
      ];
    };
  };
}
