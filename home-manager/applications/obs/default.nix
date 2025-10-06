{ pkgs, config, userSettings, lib, ... }:

{

  home.packages = [ pkgs.obs-studio ];

  # TODO: Figure out how to let obs edit these two files
  # home.file.".config/obs-studio/basic/profiles/Nix/basic.ini".source = config.lib.file.mkOutOfStoreSymlink userSettings.dotfilesDir + "/home-manager/obs/basic.ini";
  # home.file.".config/obs-studio/basic/scenes/Nix.json".source = config.lib.file.mkOutOfStoreSymlink userSettings.dotfilesDir + "/home-manager/obs/Nix.json";

  # home.file."exists".text = lib.mkIf (builtins.pathExists "/home/ren/Desktop/test/new.txt") "it exists bro";
  home.file.".config/obs-studio/themes/".source = ./themes;
  home.file.".config/obs-studio/themes/".recursive = true;

}

