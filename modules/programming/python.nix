{ config, lib, pkgs, inputs, ... }:

{
  options.modules.programming.python = lib.mkOption {
    default = false;
    type = lib.types.bool;
  };

  config = lib.mkIf config.modules.programming.python {

    home-manager.users.nino = {config, lib, pkgs,... }: {

      home.stateVersion = "22.11";
      # nixpkgs.overlays = [ inputs.emacs-overlay.overlay ];

      home.packages = with pkgs; [
        (python3.withPackages (ps: with ps; [
          tkinter
          matplotlib
        ]))
        conda
        nodePackages.pyright
      ];
    };
  };
}
