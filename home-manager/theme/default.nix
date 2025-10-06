{ lib, pkgs, ... }:

{

  imports = [
    ./fonts
    ./stylix.nix
    ./catppuccin.nix
  ];

  home.packages = with pkgs; [
    catppuccin-qt5ct
    kdePackages.breeze.qt5
    kdePackages.breeze # qt6 i think. Double check
  ];

  # Stylix works but it is stuck on kvantum instead of breeze
  # platformTheme.name == QT_QPA_PLATFORMTHEME
  #         style.name == QT_STYLE_OVERRIDE
  qt = {
    enable = true;
    platformTheme.name = "qtct";
    # style.package = pkgs.catppuccin-qt5ct; # Don't override QT_STYLE_OVERRIDE
  };
  # home.file.".config/qt5ct/qt5ct.conf".source = ./configs/qt5ct.conf;
  # home.file.".config/qt6ct/qt6ct.conf".source = ./configs/qt6ct.conf;

  gtk = {
    enable = true;
    gtk2.enable = true;
    colorScheme = "dark";
    font = lib.mkForce {
      name = "Noto Sans CJK JP Regular";
      size = 11;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.catppuccin-papirus-folders.override {
        flavor = "mocha";
        accent = "mauve";
      };
    };
  };

  home.pointerCursor = {
    hyprcursor.enable = true;
    gtk.enable = true;
    x11.enable = true;
    size = 20;
    # package = pkgs.catppuccin-cursors.mochaDark;
    # name = "catppuccin-mocha-dark-cursors";
  };

}

