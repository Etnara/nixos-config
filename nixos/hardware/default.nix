{ ... }:

{

  imports = [
    ./hardware-configuration.nix
    ./kernel.nix
    ./cpu.nix
    ./graphics.nix
    ./ssd.nix
    ./filesystem.nix
    ./pipewire.nix
    ./networking.nix
    ./bluetooth.nix
    ./printing.nix
  ];

}

