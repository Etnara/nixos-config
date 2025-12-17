{ pkgs, ... }:

{

  programs.steam = {
    enable = true;
    dedicatedServer.openFirewall = true;
    remotePlay.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    gamescopeSession.enable = true; # Doesn't work on laptop possibly because of some amd vulkan driver issue
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
  };

  networking.firewall.allowedTCPPorts = [ 7777 ]; # Terraria Multiplayer

  programs.gamemode.enable = true;

}

