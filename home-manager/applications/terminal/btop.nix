{ ... }:

{
  
  programs.btop= {
    enable = true;
    settings = {
      # color_theme = "catppuccin_mocha";
      vim_keys = true;
    };
  };

  # home.file.".config/btop/themes/catppuccin_mocha.theme".source = "${./catppuccin_mocha.theme}";
}

