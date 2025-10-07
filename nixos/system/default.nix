{ ... }:

{

  imports = [
    ./hardware
    ./users.nix
    ./timezone-locale.nix
    ./networking.nix
    ./bluetooth.nix
    ./pipewire.nix
    ./printing.nix

    ./boot.nix
    ./fonts.nix
    ./sddm.nix
    ./zsh.nix
  ];

}

