{ catppuccin, pkgs, ... }:

{

  catppuccin.limine.enable = true;

  boot = {

    loader = {
      limine = {
        enable = true;
        maxGenerations = 5;
      };
      efi.canTouchEfiVariables = true;
      timeout = 3;
    };

    initrd.verbose = false;
    consoleLogLevel = 0;
    kernelParams = [
      "quiet"
      "udev.log_level=3"
    ];

  };
  
}

