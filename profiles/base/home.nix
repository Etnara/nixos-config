{ pkgs, userSettings, ... }:

{

  home.stateVersion = "24.11";
  home.username = userSettings.username;
  home.homeDirectory = "/home/" + userSettings.username;
  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;
  news.display = "silent";

  imports = [
    ../../home-manager/fonts
    ../../home-manager/obs
    ../../home-manager/wm/${userSettings.wm}/${userSettings.wm}.nix
    ../../home-manager/wm/waybar/waybar.nix
    ../../home-manager/wm/hyprlock.nix
    ../../home-manager/zsh.nix
    ../../home-manager/virtualisation.nix
    ../../home-manager/themes/stylix.nix
    ../../home-manager/themes/catppuccin.nix
    ../../home-manager/rofi/rofi.nix
    ../../home-manager/btop.nix
    ../../home-manager/fastfetch.nix
    ../../home-manager/tmux.nix
    ../../home-manager/keepassxc.nix
    ../../home-manager/nvim/nvim.nix
    ../../home-manager/terminal/${userSettings.term}.nix
    ../../home-manager/feh.nix
    ../../home-manager/browser/${userSettings.browser}.nix
    ../../home-manager/git.nix
    ../../home-manager/anki.nix
    ../../home-manager/fcitx5.nix
    ../../home-manager/xdg.nix
    ../../home-manager/mpv.nix
  ];

  home.packages = with pkgs; [
    # System Stuff
    nwg-look # Manual Theming
    wl-clipboard
    wl-clip-persist
    kdePackages.kio # Required for some Qt application file pickers like OBS (Fixes Error: Unable to create KIO worker)
    nautilus
    discord
    brave
    libreoffice-qt
    kdePackages.kdenlive
    kdePackages.filelight
    gnome-calculator
    krita
    # ciscoPacketTracer8 # Currently one of the dependencies has a CVE
    zathura
    qbittorrent
    hyprpicker
    lutris
  ];

}

