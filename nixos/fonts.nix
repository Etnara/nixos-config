{ pkgs, ...  }:

{
  
  environment.systemPackages = with pkgs; [
    font-manager
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-monochrome-emoji
  ];

}

