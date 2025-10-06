{ pkgs, userSettings, ... }:

{

  # Copied from https://nixos.wiki/wiki/Virt-manager (25 August 2025) (Doesn't work)
  # MANUAL: virsh net-autostart default # Try outside of tmux or with sudo if it doesn't work.
  # programs.virt-manager.enable = true;
  # home.packages = with pkgs; [
  #   virt-manager
  # ];
  # users.groups.libvirtd.members = [ userSettings.username ];
  # virtualisation.libvirtd.enable = true;
  # virtualisation.spiceUSBRedirection.enable = true;

  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
    };
  };

}

