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
    # allowAliases = false; # Debugging
    cudaSupport = systemSettings.gpuType == "nvidia";
    rocmSupport = systemSettings.gpuType == "amd";
  };
  nix.package = pkgs.nix;
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
    zathura
    qbittorrent
    hyprpicker
    wl-mirror
    ani-cli
  ];

}

