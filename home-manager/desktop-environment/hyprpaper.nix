{ lib, systemSettings, ... }:

{

  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [ "${../theme/configs/wallpaper.jpg}" ];
      # Bro what is this array indexing syntax lol
      wallpaper = [ "${lib.elemAt systemSettings.monitors 0},${../theme/configs/wallpaper.jpg}" ];
    };
  };

}

