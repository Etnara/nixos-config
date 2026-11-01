{ catppuccin, pkgs, lib, userSettings, ... }:

{

  environment.systemPackages = [ pkgs.catppuccin-cursors.mochaDark ];

  services.displayManager.sddm = lib.mkDefault {
    enable = true;
    wayland.enable = true;
    wayland.compositor = "kwin";
    package = pkgs.kdePackages.sddm; # Uses libsForQt5 by default
    settings.Theme = {
      CursorTheme = "catppuccin-mocha-dark-cursors";
      CursorSize = 24;
    };
    settings.Wayland.CompositorCommand =
        "${pkgs.coreutils}/bin/env KWIN_FORCE_SW_CURSOR=1 ${pkgs.kdePackages.kwin}/bin/kwin_wayland --no-global-shortcuts --no-kactivities --no-lockscreen --locale1";
  };

  systemd.tmpfiles.rules =
    let
      # Remove Mouse Accel on Naga Trinity
      kcminputrc = pkgs.writeText "sddm-kcminputrc" ''
        [Libinput][5426][103][Razer Razer Naga Trinity]
        PointerAccelerationProfileFlat=true
        PointerAccelerationProfileAdaptive=false
        PointerAcceleration=-0.7
      '';
      # Remove Cursor Shake Magnification
      kwinrc = pkgs.writeText "sddm-kwinrc" ''
        [Plugins]
        shakecursorEnabled=false
      '';
    in [
      "d /var/lib/sddm/.config 0755 sddm sddm -"
      "L+ /var/lib/sddm/.config/kcminputrc - - - - ${kcminputrc}"
      "L+ /var/lib/sddm/.config/kwinrc - - - - ${kwinrc}"
  ];

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

