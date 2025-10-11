{ pkgs, config, userSettings, lib, ... }:

{

  programs.obs-studio.enable = true;
  programs.obs-studio.plugins = with pkgs.obs-studio-plugins; [
    obs-pipewire-audio-capture
  ];

  home.file.".config/obs-studio/themes/".source = ./themes;
  home.file.".config/obs-studio/themes/".recursive = true;

  # IMPURE
  # Source config files only if they don't already exist
  home.file.".config/obs-studio/basic/profiles/Nix/basic.ini".enable = ! builtins.pathExists "${config.home.homeDirectory}/.config/obs-studio/basic/profiles/Nix/basic.ini";
  home.file.".config/obs-studio/basic/profiles/Nix/basic.ini".source = ./basic.ini;

  home.file.".config/obs-studio/basic/scenes/Nix.json".enable = ! builtins.pathExists "${config.home.homeDirectory}/.config/obs-studio/basic/scenes/Nix.json";
  home.file.".config/obs-studio/basic/scenes/Nix.json".source = ./Nix.json;

  home.file.".config/obs-studio/user.ini".enable = ! builtins.pathExists "${config.home.homeDirectory}/.config/obs-studio/user.ini";
  home.file.".config/obs-studio/user.ini".source = ./user.ini;

}

