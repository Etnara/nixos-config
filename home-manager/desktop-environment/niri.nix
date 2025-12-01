{ config, lib, pkgs, ... }:

{

  home.packages = [ pkgs.swaybg ];

  programs.niri = {
    enable = true;
    settings = {
      hotkey-overlay.skip-at-startup = true;
      xwayland-satellite.enable = true;
      xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;
      prefer-no-csd = true;
      layout.focus-ring.active.color = "#cba6f7";

      input = {
        mouse.accel-profile = "flat";
        touchpad.accel-profile = "flat";
        touchpad.dwt = true; # Disable while typing
        keyboard.xkb.options = "caps:escape";
      };

      layer-rules = [
        {
          matches = [ { namespace = "^wallpaper$"; } ];
          place-within-backdrop = true;
        }
      ];

      window-rules = [
        {
          matches = [ { title = "^Unlock Database - KeePassXC$"; } ];
          open-floating = true;
        }
        {
          matches = [ { title = "^Picture-in-Picture$"; } ];
          open-floating = true;
        }
        {
          matches = [ { app-id = "steam"; title = "^notificationtoasts_\\d+_desktop$"; } ];
          default-floating-position = {
            relative-to = "bottom-right";
            x = 0;
            y = 0;
          };
          open-focused = false;
        }
      ];

      spawn-at-startup = [
        { argv = [ "waybar" ]; }
        { argv = [ "dunst" ]; }
        { argv = [ "hyprpaper" ]; }
        { argv = [ "swaybg" "--image" "${../theme/configs/wallpaper_blurred.jpg}" ]; }
        { argv = [ "keepassxc" ]; }
        { argv = [ "obs" "--startreplaybuffer" "--minimize-to-tray" "--disable-shutdown-check" ]; }
        { argv = [ "wl-clip-persist" "--clipboard" "regular" ]; }
      ];

      binds = with config.lib.niri.actions; {
        "Mod+Space".action.spawn = [ "rofi" "-show" "drun" ];
        "Mod+Return".action.spawn = "kitty";
        "Mod+E".action.spawn = "nautilus";
        "Mod+W".action.spawn = "librewolf";
        "Mod+M".action.spawn = "hyprlock";
        "Mod+Q".action = close-window;
        "Mod+O".action = toggle-overview;
        "Mod+Shift+M".action = quit;

        "Mod+H".action = focus-column-left;
        "Mod+J".action = focus-window-down;
        "Mod+K".action = focus-window-up;
        "Mod+L".action = focus-column-right;
        "Mod+Shift+H".action = move-column-left;
        "Mod+Shift+J".action = move-window-down;
        "Mod+Shift+K".action = move-window-up;
        "Mod+Shift+L".action = move-column-right;

        "Mod+U".action = focus-workspace-down;
        "Mod+I".action = focus-workspace-up;
        "Mod+Shift+U".action = move-column-to-workspace-down;
        "Mod+Shift+I".action = move-column-to-workspace-up;
        "Mod+Ctrl+U".action = move-workspace-down;
        "Mod+Ctrl+I".action = move-workspace-up;

        "Mod+WheelScrollDown".action = focus-column-right;
        "Mod+WheelScrollUp".action = focus-column-left;
        "Mod+Shift+WheelScrollDown".action = move-column-right;
        "Mod+Shift+WheelScrollUp".action = move-column-left;
        "Mod+Ctrl+WheelScrollDown".action = focus-workspace-down;
        "Mod+Ctrl+WheelScrollUp".action = focus-workspace-up;
        "Mod+Ctrl+Shift+WheelScrollDown".action = move-column-to-workspace-down;
        "Mod+Ctrl+Shift+WheelScrollUp".action = move-column-to-workspace-up;

        "Mod+1".action.focus-workspace = 1;
        "Mod+2".action.focus-workspace = 2;
        "Mod+3".action.focus-workspace = 3;
        "Mod+4".action.focus-workspace = 4;
        "Mod+5".action.focus-workspace = 5;
        "Mod+Shift+1".action.move-column-to-workspace = 1;
        "Mod+Shift+2".action.move-column-to-workspace = 2;
        "Mod+Shift+3".action.move-column-to-workspace = 3;
        "Mod+Shift+4".action.move-column-to-workspace = 4;
        "Mod+Shift+5".action.move-column-to-workspace = 5;

        "Mod+BracketLeft".action = consume-or-expel-window-left;
        "Mod+BracketRight".action = consume-or-expel-window-right;
        "Mod+Comma".action = consume-window-into-column;
        "Mod+Period".action = expel-window-from-column;
        "Mod+R".action = switch-preset-column-width;
        "Mod+Shift+R".action = switch-preset-window-height;
        "Mod+Ctrl+R".action = reset-window-height;
        "Mod+F".action = maximize-column;
        "Mod+Shift+F".action = fullscreen-window;
        "Mod+Ctrl+F".action = expand-column-to-available-width;
        "Mod+C".action = center-column;
        "Mod+Ctrl+C".action = center-visible-columns;
        "Mod+N".action = set-column-width "50%";

        "Mod+Equal".action = set-column-width "+10%";
        "Mod+Minus".action = set-column-width "-10%";
        "Mod+Shift+Equal".action = set-window-height "+10%";
        "Mod+Shift+Minus".action = set-window-height "-10%";

        "Mod+V".action = toggle-window-floating;
        "Mod+Shift+V".action = switch-focus-between-floating-and-tiling;
        "Mod+A".action = toggle-column-tabbed-display;
        "Mod+S".action = screenshot;
        # "Mod+Ctrl+S".action = screenshot-screen;
        # "Mod+Alt+S".action = screenshot-window;

      };

    };
  };

}

