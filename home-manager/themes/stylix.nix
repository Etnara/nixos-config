{ inputs, pkgs, lib, ... }:

let
  themePath = "/catppuccin-mocha.yaml";
  themePolarity = "dark";
in
  {

  stylix = {
    enable = true;
    # home.file.".currenttheme".text = userSettings.theme;
    autoEnable = false;
    base16Scheme = ./. + themePath;
    polarity = themePolarity;
    # stylix.image = pkgs.fetchurl {
    #   url = backgroundUrl;
    #   sha256 = backgroundSha256;
    # };

    targets = {
      # qt.enable = true; # Works but is stuck on kvantum
      # kde.enable = true; # I don't see a difference in dolphin
      gtk.enable = true; # Fixes theming in calculator
      anki.enable = true;
    };

    # fonts = {
    #   monospace = {
    #     package = pkgs.nerd-fonts.jetbrains-mono;
    #     name = "JetBrainsMonoNL Nerd Font";
    #   };
    #   serif = {
    #     package = pkgs.nerd-fonts.jetbrains-mono;
    #     name = "JetBrainsMonoNL Nerd Font";
    #   };
    #   sansSerif = {
    #     package = pkgs.nerd-fonts.jetbrains-mono;
    #     name = "JetBrainsMonoNL Nerd Font";
    #   };
    #   emoji = {
    #     name = "Noto Emoji";
    #     package = pkgs.noto-fonts-monochrome-emoji;
    #   };

    # sizes = {
    #   terminal = 18;
    #   applications = 12;
    #   popups = 12;
    #   desktop = 12;
    # };
  };

  # home.file.".config/hypr/hyprpaper.conf".text = ''
  #   preload = ''+config.stylix.image+''
  #   wallpaper = ,''+config.stylix.image+''
  # '';

  # fonts.fontconfig.defaultFonts = {
  #   monospace = [ userSettings.font ];
  #   sansSerif = [ userSettings.font ];
  #   serif = [ userSettings.font ];
  # };
}

