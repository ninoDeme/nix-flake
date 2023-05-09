{ config, lib, pkgs, ... }:

{
  imports = [
    ./steam.nix
  ];

  config = lib.mkIf (lib.lists.any (x: x) (lib.attrsets.attrValues config.modules.gaming)) {
    programs.gamemode.enable = true;
  };

}
