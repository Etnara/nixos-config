{ pkgs, pkgs-unstable, ... }:

{

  imports = [
    ./steam.nix
    ./alvr.nix
  ];

  environment.systemPackages = with pkgs; [
    lutris
    mangohud
    pkgs-unstable.osu-lazer-bin
    prismlauncher
    (retroarch.withCores (cores: with cores; [
      fbneo
      ppsspp
    ]))
  ];

}

