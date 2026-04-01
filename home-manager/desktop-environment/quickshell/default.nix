{ qml-niri, pkgs, ... }:

{

  programs.quickshell = {
    enable = true;
    systemd.enable = true;
    package = qml-niri.packages.${pkgs.stdenv.hostPlatform.system}.quickshell;
  };

}

