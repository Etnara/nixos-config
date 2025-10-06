{ inputs, pkgs, lib, ... }:

{

  stylix = {
    enable = true;
    autoEnable = false;
    base16Scheme = ./configs/catppuccin-mocha.yaml;
    polarity = "dark";
    # stylix.image = pkgs.fetchurl {
    #   url = backgroundUrl;
    #   sha256 = backgroundSha256;
    # };

    targets = {
      # qt.enable = true; # Works but is stuck on kvantum
      # kde.enable = true; # Doesn't seem to work in kde apps
      gtk.enable = true; # Fixes theming in calculator
      anki.enable = true;
    };
  };

}

