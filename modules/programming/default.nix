{ config, lib, pkgs, ... }:

{
  imports = [
    ./python.nix
    ./nix.nix
    ./java.nix
  ];
}
