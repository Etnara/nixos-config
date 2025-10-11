{ systemSettings, ... }:

let
  nvidia = (systemSettings.gpuType == "nvidia");
  amd = (systemSettings.gpuType == "amd");
in 
{

  services.xserver.videoDrivers = (
    if nvidia then [ "nvidia" ]
    else if amd then [ "amdgpu" ]
    else [ "modesetting" "fbdev" ]
  );

  boot.initrd.kernelModules = (
    if nvidia then [ "nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm" ]
    else if amd then [ "amdgpu" ]
    else [ ]
  );

  hardware.nvidia = {
    modesetting.enable = nvidia;
    open = nvidia;
    nvidiaSettings = nvidia;
  };

}

