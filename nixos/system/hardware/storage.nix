{ pkgs, ... }:

{

  services.fstrim.enable = true;
  environment.systemPackages = [ pkgs.smartmontools ];

}

