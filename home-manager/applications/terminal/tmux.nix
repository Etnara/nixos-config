{ pkgs, ... }:

{
  
  programs.tmux = {
    enable = true;
    # plugins = with pkgs.tmuxPlugins; [
    #   catppuccin
    # ];
    # Correct colours while in tmux
    # TODO: Try to figure out a way to not hardcode $TERM
    # set-option -a terminal-features '${builtins.getEnv "TERM"}:RGB'
    terminal = "screen-256color";
    extraConfig = ''
      set-option -a terminal-features 'kitty:RGB'
      set -g mouse on
      set -g escape-time 0
    '';
  };

}

