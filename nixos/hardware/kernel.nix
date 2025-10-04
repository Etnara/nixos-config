{ pkgs, ... }:

{

  boot = {

    kernelPackages = pkgs.linuxKernel.packages.linux_xanmod;

    initrd.availableKernelModules = [ "ahci" "xhci_pci" "virtio_pci" "sr_mod" "virtio_blk" ];
    initrd.kernelModules = [ ];
    kernelModules = [ "kvm-intel" ];
    extraModulePackages = [ ];

    kernelParams = [
      "splash"
      "quiet"
      "loglevel=3"
      "systemd.show_status=auto"
    ];

  };

}

