{ pkgs, userSettings, ... }:

{

  programs.wireshark = {
    enable = true;
    package = pkgs.wireshark;
  };
  users.users.${userSettings.username}.extraGroups = [ "wireshark" ];

}

