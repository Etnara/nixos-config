{ ... }:

{

  imports = [
    ./cpu.nix
    ./graphics.nix
    ./storage.nix
    ./kernel.nix
    ./filesystem.nix
  ];

  hardware.enableRedistributableFirmware = true;

}

