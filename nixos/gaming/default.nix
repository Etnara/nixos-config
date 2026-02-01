{ pkgs, ... }:

{

  imports = [
    ./steam.nix
    ./alvr.nix
  ];

  environment.systemPackages = with pkgs; [
    lutris
    osu-lazer-bin
    prismlauncher
  ];

}

