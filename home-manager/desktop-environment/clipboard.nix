{ pkgs, ... }:

{

  services.cliphist.enable = true;

  home.packages = with pkgs; [
    wl-clipboard
    wl-clip-persist
  ];

}
