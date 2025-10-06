{ ... }:

{

  home.file.".config".source = ./.;
  home.file.".config".recursive = true;

  programs.waybar = {
    enable = true;
    systemd.enable = false;

    settings.mainBar.include = [
      ./waybar/configs/config
    ];
    style = "@import \"styling/style.css\";";

  };

}

