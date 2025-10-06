{ catppuccin, ... }:

{

  catppuccin = {
    enable = false;
    flavor = "mocha";
    accent = "mauve";
    bat.enable = true;
    brave.enable = true; # TODO: Doesn't work
    btop.enable = true;
    cursors.enable = true;
    cursors.accent = "dark";
    delta.enable = true;
    dunst.enable = true;
    fcitx5.enable = true;
    fcitx5.enableRounded = true;
    kitty.enable = true;
    librewolf.enable = true;
    mpv.enable = true;
    obs.enable = true;
    starship.enable = true;
    tmux.enable = true;
    yazi.enable = true;
    zathura.enable = true;
    zsh-syntax-highlighting.enable = true;
  };

}

