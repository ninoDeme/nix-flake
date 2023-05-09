{ config, lib, pkgs, ... }:

{
  imports = [
    ./i3.nix
    ./gnome.nix
  ];
}
