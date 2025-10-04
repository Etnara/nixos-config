{ pkgs, ... }:

{

  boot = {

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    plymouth = {
      enable = true;
      theme = "lone";
      themePackages = with pkgs; [
        (adi1090x-plymouth-themes.override {
          selected_themes = [ "lone" ];
        })
      ];
      extraConfig = ''
        [Daemon]
        DeviceScale=2
      '';
    };

  };
  
}

