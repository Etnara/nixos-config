{ pkgs, lib, systemSettings, userSettings, ...}:

{

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false; # Needed for withUWSM. https://wiki.hyprland.org/Useful-Utilities/Systemd-start/

    settings = {
      "monitor" = ",1920x1080@60,auto,1"; # VM Hack
      "$mod" = "SUPER";
      "$fileManager" = "nautilus";
      "$browser" = "${userSettings.browser}";
      "$menu" = "rofi -show drun";

      # TODO: Use uwsm app
      exec-once = [
        "waybar"
        "hyprpaper"
        "dunst"
        "keepassxc"
        "obs --startreplaybuffer --minimize-to-tray --disable-shutdown-check"
      ];

      input = {
        kb_options = "caps:escape";
        accel_profile = "flat";
        touchpad = {
          natural_scroll = true;
          disable_while_typing = false;
        };
      };

      bind = [
        "$mod, return, exec, ${userSettings.term}"
        "$mod, q, killactive"
        "$mod, e, exec, $fileManager"
        "$mod, w, exec, $browser"
        "$mod, v, togglefloating"
        "$mod, space, exec, $menu"
        "$mod, m, exec, hyprlock"
        "$mod, f, fullscreen"
        "$mod SHIFT, f, fullscreen, 1"
        "ALT, Tab, cyclenext"
        "ALT SHIFT, Tab, cyclenext, prev"

        "$mod, h, movefocus, l"
        "$mod, j, movefocus, d"
        "$mod, k, movefocus, u"
        "$mod, l, movefocus, r"

        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 10"
        "$mod, s, togglespecialworkspace"

        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod SHIFT, 9, movetoworkspace, 9"
        "$mod SHIFT, 0, movetoworkspace, 10"
        "$mod SHIFT, s, movetoworkspace, special"

        ", Print, exec, grimblast --notify copysave screen"
        "$mod, Print, exec, grimblast --notify copysave active"
        "$mod SHIFT, Print, exec, grimblast --notify copysave area"
      ];

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      gestures = {
        gesture = "3, horizontal, workspace";
      };

      general = {
        border_size = 2;
        "col.active_border" = "0xffcba6f7";
        "col.inactive_border" = "0xff313244";
      };

      decoration = {
        rounding = 20;
      };

      misc = {
        disable_hyprland_logo = true;
      };

      xwayland = {
        force_zero_scaling = true;
      };

      windowrule = [
        "float, class:org.keepassxc.KeePassXC, title:Unlock Database - KeePassXC"
      ];
    };

  };

}

