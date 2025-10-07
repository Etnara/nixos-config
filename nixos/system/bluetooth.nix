{ pkgs, ... }:

{

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
  };

  environment.systemPackages = [ pkgs.overskride ];

}

