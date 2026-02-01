{ pkgs, ... }:

let
  # https://github.com/alvr-org/ALVR/issues/2792
  # Needed because of some CUDA external library shenanigans
  pkgs-alvr-20-6-1 = import (pkgs.fetchFromGitHub {
    owner = "NixOS";
    repo = "nixpkgs";
    rev = "24.05";
    sha256 = "sha256-vboIEwIQojofItm2xGCdZCzW96U85l9nDW3ifMuAIdM=";
  }) { inherit (pkgs) system; };
in
{

  programs.alvr = {
    enable = true;
    openFirewall = true;
    package = pkgs-alvr-20-6-1.alvr;
  };

}

