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

  gtk = {
    enable = true;
    gtk2.enable = true;
    colorScheme = "dark";
    font = lib.mkForce {
      name = "Noto Sans CJK JP Regular";
      size = 11;
    };

    # Compare this to stylix because this theme
    # doesn't work well with the calculator
    # theme = {
    #   package = pkgs.catppuccin-gtk.override {
    #     variant = "mocha";
    #     accents = [ "mauve" ];
    #   };
    #   name = "catppuccin-mocha-mauve-standard";
    # };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.catppuccin-papirus-folders.override {
        flavor = "mocha";
        accent = "mauve";
      };
    };
  };


  qt = {
    enable = true;
    platformTheme.name = "qtct"; # Manual
    
    # Included at the bottom of this file instead of here
    # Because it sets style.name to Catppuccin-Mocha instead of Breeze
    # style.package = pkgs.catppuccin-qt5ct;

    # platformTheme.name == QT_QPA_PLATFORMTHEME
    #         style.name == QT_STYLE_OVERRIDE
    # I like the breeze style (round and modern)
    # qtct works perfectly for qt5 apps but dies on kde and I can't unset QT_STYLE_OVERRIDE
    # Stylix works but it is stuck on kvantum instead of breeze
    # This is a fools errand
    # I've spent 3 days trying to figure this out and I give up
    # I'm just not gonna use dolphin
  };

  home.pointerCursor = {
    hyprcursor.enable = true;
    gtk.enable = true;
    x11.enable = true;
    size = 20;
    # package = pkgs.catppuccin-cursors.mochaDark;
    # name = "catppuccin-mocha-dark-cursors";
  };

  services.dunst = {
    enable = true;
    settings = {
      global = {
        corner_radius = 20;
      };
    };
  };

  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [ "${./wallpaper.jpg}" ];
      # Bro what is this array indexing syntax lol
      wallpaper = [ "${lib.elemAt systemSettings.monitors 0},${./wallpaper.jpg}" ];
    };
  };

  services.hyprpolkitagent.enable = true;

  home.packages = with pkgs; [
    grim # Screenshot
    slurp # Screen Selection
    grimblast # grim + slurp tool
    wlogout # Configure this later
    catppuccin-qt5ct
    kdePackages.breeze.qt5
    kdePackages.breeze # qt6 i think. Double check
  ];

}

