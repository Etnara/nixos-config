{ pkgs, userSettings, ... }:

{

  home.stateVersion = "24.11";
  home.username = userSettings.username;
  home.homeDirectory = "/home/" + userSettings.username;
  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;
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
  ];

}

