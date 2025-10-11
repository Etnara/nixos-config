{ ... }:

{

  imports = [
    ./cpu.nix
    ./graphics.nix
    ./ssd.nix
    ./kernel.nix
    ./filesystem.nix
  ];

  hardware.enableRedistributableFirmware = true;

}

