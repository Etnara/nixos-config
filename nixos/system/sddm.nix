{ catppuccin, pkgs, lib, userSettings, ... }:

{

  services.displayManager.sddm = lib.mkDefault {
    enable = true;
    wayland.enable = true;
    package = pkgs.kdePackages.sddm; # Uses libsForQt5 by default
  };

  catppuccin = {
    flavor = "mocha";
    accent = "mauve";
    sddm = {
      enable = true;
      fontSize = "16";
      background = null;
    };
  };

  # Hyprland
  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };

  programs.niri.enable = true;

}

