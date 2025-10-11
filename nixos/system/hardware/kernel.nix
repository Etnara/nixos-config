{ systemSettings, pkgs, ... }:

let
  intel = (systemSettings.cpuType == "intel");
  amd = (systemSettings.cpuType == "amd");
  qemu = (systemSettings.cpuType == "qemu");
in
{

  boot = {

    kernelPackages = pkgs.linuxKernel.packages.linux_xanmod;

    initrd.availableKernelModules = [ "ahci" "nvme" "xhci_pci" "usbhid" "usb_storage" "sd_mod" ] ++ (
      if intel then [ "vmd" ]
      else if amd then [ ]
      else if qemu then [ "virtio_net" "virtio_pci" "virtio_mmio" "virtio_blk" "virtio_scsi" "9p" "9pnet_virtio" ]
      else [ ]
    );

    initrd.kernelModules = [ ] ++ (
      if intel then [ ]
      else if amd then [ ]
      else if qemu then [ "virtio_balloon" "virtio_console" "virtio_rng" "virtio_gpu" ]
      else [ ]
    );

    kernelModules = [ ] ++ (
      if intel then [ "kvm-intel" ]
      else if amd then [ "kvm-amd"  ]
      else if qemu then [ ]
      else [ ]
    );

    extraModulePackages = [ ];

  };

}

