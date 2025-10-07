{ userSettings, secrets, ... }:

{

  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/boot";
    fsType = "vfat";
    options = [ "fmask=0077" "dmask=0077" ];
  };

  swapDevices = [ { device = "/dev/disk/by-label/swap"; } ];

  fileSystems."/home/${userSettings.username}/Aurora" = {
    device = "//aurora.borealis/Files";
    fsType = "cifs";
    options = [
      "username=ren"
      "password=${secrets.smbPassword}"
      "uid=1000" # Set user owner to me
      "gid=1000" # Set group owner to me
      # Don't die if I can't connect
      "x-systemd.automount"
      "noauto"
    ];
  };

}

