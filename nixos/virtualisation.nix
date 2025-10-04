{ pkgs, systemSettings, userSettings, ... }:

let
  isGuest = (systemSettings.cpuType == "qemu" || systemSettings.gpuType == "qemu");
in
{

  services.qemuGuest.enable = isGuest;
  services.spice-vdagentd.enable = isGuest;

  # Copied from https://nixos.wiki/wiki/Virt-manager (25 August 2025) (Doesn't work)
  programs.virt-manager.enable = true;
  environment.systemPackages = with pkgs; [
    virtiofsd # For sharing filesystem
    # Add the following into virt-manager filesystem xml
    # <binary path="/run/current-system/sw/bin/virtiofsd"/>
  ];
  users.groups.libvirtd.members = [ userSettings.username ];
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;

  # dconf.settings = {
  #   "org/virt-manager/virt-manager/connections" = {
  #     autoconnect = ["qemu:///system"];
  #     uris = ["qemu:///system"];
  #   };
  # };

}

