{ ... }:

{

  imports = [
    ./hardware-configuration.nix
    ./cpu.nix
    ./graphics.nix
    ./ssd.nix
    ./kernel.nix
    ./filesystem.nix
  ];

}

