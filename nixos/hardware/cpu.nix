{ systemSettings, ... }:

{

  nixpkgs.hostPlatform = systemSettings.architecture;
  hardware.cpu.amd.updateMicrocode = (systemSettings.cpuType == "amd");
  hardware.cpu.intel.updateMicrocode = (systemSettings.cpuType == "intel");

}

