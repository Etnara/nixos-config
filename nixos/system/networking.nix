{ systemSettings, pkgs, ... }:

{

  networking.hostName = systemSettings.hostname;
  networking.networkmanager.enable = true;
  environment.systemPackages = [ pkgs.wireguard-tools ]; # MANUAL: nmcli connection import type wireguard file vpn.conf

}

