{ pkgs, ... }:

{

  imports = [
    ./steam.nix
    ./alvr.nix
  ];

  environment.systemPackages = with pkgs; [
    lutris
    mangohud
    osu-lazer-bin
    prismlauncher
  ];

}

