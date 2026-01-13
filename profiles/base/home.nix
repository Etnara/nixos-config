{ pkgs, userSettings, systemSettings, ... }:

{

  programs.home-manager.enable = true;
  home = {
    stateVersion = "24.11";
    username = userSettings.username;
    homeDirectory = "/home/" + userSettings.username;
  };
  nixpkgs.config = {
    allowUnfree = true;
    cudaSupport = systemSettings.gpuType == "nvidia";
    rocmSupport = systemSettings.gpuType == "amd";
  };
  news.display = "silent";

  imports = [
    ../../home-manager/applications
    ../../home-manager/desktop-environment
    ../../home-manager/theme
  ];

  home.packages = with pkgs; [
    nautilus
    discord
    brave
    libreoffice-qt
    kdePackages.kdenlive
    baobab
    gnome-calculator
    krita
    # ciscoPacketTracer8 # Currently one of the dependencies has a CVE
    zathura
    qbittorrent
    hyprpicker
    wl-mirror
  ];

}

