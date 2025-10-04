{ pkgs, ... }:

pkgs.mkShell {

  packages = with pkgs; [
    gcc
    cargo
  ];

  shellHook = ''
    zsh
  '';

}

