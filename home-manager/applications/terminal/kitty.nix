{ ... }:

{

  programs.kitty= {
    enable = true;
    themeFile = "Catppuccin-Mocha"; # Built into package
    font.name = "JetBrainsMonoNL Nerd Font";
    settings = {
      # I had to add some padding b/c of rounded corners
      # I don't know the difference between these two options
      # window_padding_width = "10";
      window_margin_width = 10;
      # For indent-blankline.nvim scope
      modify_font = "underline_position 2";
      cursor_trail = 1;
    };
  };

}

