{ lib, pkgs, systemSettings, userSettings, ... }:

{

  system.stateVersion = "24.11";
  nixpkgs.config = {
    allowUnfree = true;
    cudaSupport = systemSettings.gpuType == "nvidia";
    rocmSupport = systemSettings.gpuType == "amd";
  };
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      substituters = [ "https://cache.nixos-cuda.org" ];
      trusted-public-keys = [ "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M=" ];
      download-buffer-size = 1073741824; # 1 GiB
    };
    gc = {
      automatic = true;
      options = "--delete-older-than +10";
      dates = "weekly";
    };
  };
  catppuccin.cache.enable = true;

  imports = [
    ../../nixos/system
    ../../nixos/gaming
    ../../nixos/virtualisation
    ../../nixos/security
  ]
  ++ lib.optional userSettings.LAMPP.enable ../../nixos/lampp.nix
  ;

  environment.systemPackages = with pkgs; [
    home-manager
    git
    wget
    unar
    sshfs
    nvd # Nix diff for number of package updates widget
    caligula # Burning ISOs
  ];

}

