{ userSettings, ... }:

{

  virtualisation.docker.enable = true;
  users.users.${userSettings.username}.extraGroups = [ "docker" ];
  hardware.nvidia-container-toolkit.enable = true;

}

