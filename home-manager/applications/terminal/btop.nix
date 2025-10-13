{ pkgs, systemSettings, ... }:

{
  
  programs.btop= {
    enable = true;
    package = pkgs.btop.override {
      cudaSupport = systemSettings.gpuType == "nvidia";
      rocmSupport = systemSettings.gpuType == "amd";
    };
    settings = {
      # color_theme = "catppuccin_mocha";
      vim_keys = true;
    };
  };

  # home.file.".config/btop/themes/catppuccin_mocha.theme".source = "${./catppuccin_mocha.theme}";
}

