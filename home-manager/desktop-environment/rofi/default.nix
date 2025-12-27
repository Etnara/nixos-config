{ pkgs, ... }:

{

  home.packages = with pkgs; [
    (rofi.override {
      plugins = [ rofi-calc ];
    })
  ];

  home.file.".config/rofi/config.rasi".source = "${./config.rasi}";

}

