{ ... }:

{

  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    shellWrapperName = "y";
    keymap = {
      mgr.prepend_keymap = [
        { on = [ "g" "/" ]; run = "cd /"; desc = "Go /"; }
        { on = [ "g" "n" ]; run = "cd /nix"; desc = "Go /nix"; }
        { on = [ "g" "s" ]; run = "cd ~/.steam/steam/steamapps/common/"; desc = "Go Steam"; }
        { on = [ "g" "l" ]; run = "cd ~/.local/share"; desc = "Go ~/.local/share"; }
        { on = [ "g" "c" ]; run = "cd ~/.dotfiles"; desc = "Go ~/.dotfiles"; }
        { on = [ "g" "C" ]; run = "cd ~/.config"; desc = "Go ~/.config"; }
        { on = [ "g" "D" ]; run = "cd ~/Desktop"; desc = "Go Desktop"; }
        { on = [ "g" "m" ]; run = "cd ~/Projects"; desc = "Go Projects"; }
        { on = [ "g" "G" ]; run = "cd ~/Games"; desc = "Go Games"; }
        { on = [ "g" "a" ]; run = "cd ~/Aurora"; desc = "Go Aurora"; }
        { on = [ "g" "p" ]; run = "cd ~/Aurora/Backups/Pictures || cd ~/Pictures"; desc = "Go Pictures"; }
        { on = [ "g" "v" ]; run = "cd ~/Aurora/Backups/Videos || cd ~/Videos"; desc = "Go Videos"; }
        { on = [ "g" "P" ]; run = "cd ~/Pictures"; desc = "Go ~/Pictures"; }
        { on = [ "g" "V" ]; run = "cd ~/Videos"; desc = "Go ~/Videos"; }
      ];
    };
  };

  # Nix Catppuccin Yazi module broke so I have to do this manually
  home.file.".config/yazi/theme.toml".source = ./catppuccin-mocha-mauve.toml;
  home.file.".config/yazi/syntect.tmTheme".source = ./catppuccin-mocha.tmTheme;

}

