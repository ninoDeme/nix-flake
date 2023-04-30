{ pkgs, ...}: {

  home.stateVersion = "22.11";
  home.username = "nino";
  home.homeDirectory = "/home/nino";

  # programs.fish = {
  #   enable = true;
  # };

  home.packages = with pkgs; [
    htop
    fish
    neovim
    emacs
    exa
    fzf
    fd
    ripgrep
    texlive.combined.scheme-medium
    binutils
    ];

  home.file = {
    ".vim".source = ./dotfiles/.vim;
    ".doom.d".source = ./dotfiles/.doom.d;
    ".gitconfig".source = ./dotfiles/.gitconfig;
  };
}
