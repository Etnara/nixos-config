{ pkgs, ... }:

{

  services.easyeffects.enable = false; # Breaks SongRec when enabled

  home.packages = [ pkgs.audacity ];

}

