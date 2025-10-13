{ pkgs, ... }:

pkgs.mkShell {

  packages = with pkgs; [
    gcc
    cargo
    python3
  ];

  shellHook = ''
    zsh
  '';

}

