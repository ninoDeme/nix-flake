{ pkgs, config, lib, inputs, ...}: {

  home.stateVersion = "22.11";
  home.username = "nino";
  home.homeDirectory = "/home/nino";

  xdg.configHome = "${config.home.homeDirectory}/.config";


  # nixpkgs.config = {
  #   allowUnfree = true;
  # };

  nixpkgs.overlays = [  # This overlay will pull the latest version of Discord
    (self: super: {
      discord = super.discord.overrideAttrs (
        _: { src = builtins.fetchTarball {
               url = "https://discord.com/api/download?platform=linux&format=tar.gz";
               sha256 = "1z980p3zmwmy29cdz2v8c36ywrybr7saw8n0w7wlb74m63zb9gpi";
             };}
      );
    })
    (final: prev: {neovim = inputs.nixpkgs-unstable.neovim;})
  ];

  home.packages = with pkgs; [
    htop
    curl
    git
    fish
    exa
    fzf
    binutils
    discord
    firefox
    spotify
    gimp
    nodejs
    neovim
  ];


  home.activation = {
    cloneBareRepository = lib.hm.dag.entryAfter ["installPackages"] ''
      if [ ! -d "${config.home.homeDirectory}/.dotfiles" ]; then
        XDG_CONFIG_HOME=${config.xdg.configHome}
        PATH="${config.home.path}/bin:$PATH"
        curl -Lks https://raw.githubusercontent.com/ninoDeme/dotfiles/main/scripts/Bare.sh | bash
      fi
    '';
  };
}
