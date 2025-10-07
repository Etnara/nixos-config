{ userSettings, secrets, ... }:

{

  users.users.${userSettings.username} = {
    password = "${secrets.userPassword}";
    isNormalUser = true;
    description = userSettings.name;
    extraGroups = [ "networkmanager" "wheel" ];
    packages = [];
  };

}

