{ systemSettings, ... }:

{

  programs.hyprlock = {
    enable = true;
    settings = {

      general = {
        grace = 3600;
        ignore_empty_input = true;
        hide_cursor = true;
        no_fade_in = false;
      };

      background = [ {
        # path = "screenshot";
        path = "${../theme/configs/wallpaper.jpg}";
        blur_passes = 2;
        blur_size = 8;
      } ];

      label = [
        # Time Hour
        {
          monitor = "";
          text = "cmd[update:1000] echo -e \"$(date +\"%H\")\"";
          color = "rgb(205, 214, 244)";
          shadow_pass = 2;
          shadow_size = 3;
          shadow_color = "rgb(0,0,0)";
          shadow_boost = 1.2;
          font_size = if systemSettings.HiDPI then 150 else 115;
          font_family = "AlfaSlabOne";
          position = if systemSettings.HiDPI then "0, -250" else "0, -165";
          halign = "center";
          valign = "top";
        }
        # Time Minute
        {
          monitor = "";
          text = "cmd[update:1000] echo -e \"$(date +\"%M\")\"";
          # color = 0xff$color0
          color = "rgb(205, 214, 244)";
          font_size = if systemSettings.HiDPI then 150 else 115;
          font_family = "AlfaSlabOne";
          position = if systemSettings.HiDPI then "0, -420" else "0, -300";
          halign = "center";
          valign = "top";
        }
        # Date
        {
          monitor = "";
          text = "cmd[update:1000] echo -e \"$(date +\"%-d %B %Y\")\"";
          color = "rgb(205, 214, 244)";
          font_size = if systemSettings.HiDPI then 14 else 11;
          font_family = "JetBrains Mono Nerd Font Mono ExtraBold";
          position = if systemSettings.HiDPI then "0, 60" else "0, 50";
          halign = "center";
          valign = "center";
        }
        # Weekday
        {
          monitor = "";
          text = "cmd[update:1000] echo -e \"$(date +\"%A\")\"";
          color = "rgb(205, 214, 244)";
          font_size = if systemSettings.HiDPI then 14 else 11;
          font_family = "JetBrains Mono Nerd Font Mono ExtraBold";
          position = if systemSettings.HiDPI then "0, 36" else "0, 26";
          halign = "center";
          valign = "center";
        }
      ];

      input-field = [ {
        monitor = "";
        size = if systemSettings.HiDPI then "300, 60" else "225, 45";
        halign = "center";
        valign = "center";
        position = "0, -50";
        fade_on_empty = false;

        outline_thickness = if systemSettings.HiDPI then 5 else 4;
        outer_color = "rgb(cba6f7)";
        inner_color = "rgb(313244)";
        font_color = "rgb(cdd6f4)";
        check_color = "rgb(cba6f7)";
        fail_color = "rgb(f38ba8)";
        capslock_color = "rgb(f9e2af)";

        placeholder_text = "<i>Input Password</i>";
        fail_text = "<i>$FAIL <b>($ATTEMPTS)</b></i>";
        dots_center = true;
        shadow_passes = 2;
      } ];

    };
  };

}

