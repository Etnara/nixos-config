{ pkgs, systemSettings, userSettings, ... }:

let
  isGuest = (systemSettings.cpuType == "qemu" || systemSettings.gpuType == "qemu");
in
{

  services.qemuGuest.enable = isGuest;
  services.spice-vdagentd.enable = isGuest;

  # MANUAL: sudo virsh net-autostart default
  programs.virt-manager.enable = true;
  virtualisation.libvirtd = {
    enable = true;
    qemu.vhostUserPackages = [ pkgs.virtiofsd ]; # Shared folders
  };
  users.groups.libvirtd.members = [ userSettings.username ];
  virtualisation.spiceUSBRedirection.enable = true;
  programs.dconf.enable = true; # Configured but not enabled by virt-manager

}

