{ systemSettings, ... }:

let
  nvidia = (systemSettings.gpuType == "nvidia");
  amd = (systemSettings.gpuType == "amd");
in 
{

  services.xserver.videoDrivers = (
    if nvidia then
      [ "nvidia" ]
    else if amd then
      [ "amdgpu" ]
    else
      [ "modesetting" "fbdev" ]
  );

  hardware.amdgpu.initrd.enable = amd;
    
  hardware.nvidia = {
    modesetting.enable = nvidia;
    open = nvidia;
    nvidiaSettings = nvidia;
  };

}

