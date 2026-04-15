{ ... }:

{

  imports = [
    ./hardware
    ./users.nix
    ./timezone-locale.nix
    ./networking.nix
    ./bluetooth.nix
    ./audio.nix
    ./printing.nix

    ./boot.nix
    ./fonts.nix
    ./sddm.nix
    ./zsh.nix
  ];

  # udev rule to allow configuration of Keychron Q2 Max
  services.udev.extraRules = ''
      KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="3434", ATTRS{idProduct}=="0820", MODE="0660", GROUP="users", TAG+="uaccess", TAG+="udev-acl"
      KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="3434", ATTRS{idProduct}=="d030", MODE="0660", GROUP="users", TAG+="uaccess", TAG+="udev-acl"
    '';

}

