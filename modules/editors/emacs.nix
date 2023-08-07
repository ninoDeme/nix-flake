{ config, lib, pkgs, inputs, ... }:

{
  options.modules.editors.emacs = lib.mkOption {
    default = false;
    type = lib.types.bool;
  };



  config = lib.mkIf config.modules.editors.emacs {

    fonts.fonts = [ pkgs.emacs-all-the-icons-fonts ];

    home-manager.users.nino = {config, lib, pkgs, inputs, ... }: {

      home.stateVersion = "22.11";
      nixpkgs.overlays = [ inputs.emacs-overlay.overlay ];

      home.packages = with pkgs; [
        binutils
        git
        curl
        ((emacsPackagesFor emacsNativeComp).emacsWithPackages
          (epkgs: [ epkgs.vterm ]))
        sqlite
        fd
        ripgrep
        texlive.combined.scheme-medium
        editorconfig-core-c
      ];

      # fonts.fonts = [ pkgs.emacs-all-the-icons-fonts ];

      home.activation = {
        installDoomEmacs = lib.hm.dag.entryAfter ["installPackages"] ''
        XDG_CONFIG_HOME=${config.xdg.configHome}
        if [ ! -d "$XDG_CONFIG_HOME/emacs" ]; then
           PATH="${config.home.path}/bin:$PATH"
           git clone --depth=1 --single-branch "https://github.com/doomemacs/doomemacs" "$XDG_CONFIG_HOME/emacs"
        fi
      '';
      };

    };
  };
}
