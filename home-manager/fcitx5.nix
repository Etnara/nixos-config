{ pkgs, ... }:

{

  i18n.inputMethod = {
    type = "fcitx5";
    enable = true;
    fcitx5 = {
      waylandFrontend = true;
      addons = with pkgs; [
        fcitx5-anthy # Japanese
        fcitx5-chinese-addons
      ];
      settings = {
        addons = {
          classicui.globalSection.Theme = "catppuccin-mocha-mauve";
          notifications.sections.HiddenNotifications = {
            "0" = "enumerate-group";
          };
        };
        globalOptions = {
          "Hotkey/TriggerKeys" = { "0" = "Alt+`"; };
          "Hotkey/EnumerateGroupForwardKeys" = { "0" = "Alt+~"; };
          # Disable notification every time you switch groups
          "Behavior/DisabledAddons" = { "0" = "notificationitem"; };
        };
        inputMethod = {
          GroupOrder."0" = "Japanese";
          GroupOrder."1" = "Chinese";

          "Groups/0" = {
            Name = "Japanese";
            "Default Layout" = "us";
            DefaultIM = "anthy";
          };
          "Groups/0/Items/0".Name = "keyboard-us";
          "Groups/0/Items/1".Name = "anthy";

          "Groups/1" = {
            Name = "Chinese";
            "Default Layout" = "us";
            DefaultIM = "pinyin";
          };
          "Groups/1/Items/0".Name = "keyboard-us";
          "Groups/1/Items/1".Name = "pinyin";
        };
      };
    };
  };

}

