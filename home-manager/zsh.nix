{ systemSettings, userSettings, ... }:

{

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;
    shellAliases = {
      ls = "eza";
      ssh = "kitten ssh";
      ne = "cd ~/.dotfiles; tmux new-session 'nvim' \\; new-window '$SHELL' \\; select-window -t 0";
      nu = "nix flake update --flake ~/.dotfiles";
      nr = "sudo nixos-rebuild switch --flake ~/.dotfiles#${systemSettings.hostname}";
      nh = "home-manager switch --flake ~/.dotfiles#${userSettings.username} --show-trace";
      nd = "nix develop ~/.dotfiles";
      l = "yy";
    };
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    options = [ "--cmd cd" ]; # Alias cd to z
  };

  programs.eza = {
    enable = true;
    enableZshIntegration = true;
    theme = {
      colourful = true;

      filekinds = {
        normal.foreground = "#cdd6f4";
        directory.foreground = "#cba6f7";
        symlink.foreground = "#89b4fa";
        pipe.foreground = "#bac2de";
        block_device.foreground = "#eba0ac";
        char_device.foreground = "#eba0ac";
        socket.foreground = "#bac2de";
        special.foreground = "#cba6f7";
        executable.foreground = "#a6e3a1";
        mount_point.foreground = "#94e2d5";
      };

      perms = {
        user_read.foreground = "#f38ba8";
        user_read.is_bold = true;
        user_write.foreground = "#f9e2af";
        user_write.is_bold = true;
        user_execute_file.foreground = "#a6e3a1";
        user_execute_file.is_bold = true;
        user_execute_other.foreground = "#a6e3a1";
        user_execute_other.is_bold = true;
        group_read.foreground = "#f38ba8";
        group_write.foreground = "#f9e2af";
        group_execute.foreground = "#a6e3a1";
        other_read.foreground = "#f38ba8";
        other_write.foreground = "#f9e2af";
        other_execute.foreground = "#a6e3a1";
        special_user_file.foreground = "#cba6f7";
        special_other.foreground = "#7f849c";
        attribute.foreground = "#9399b2";
      };

      size = {
        major.foreground = "#a6adc8";
        minor.foreground = "#89dceb";
        number_byte.foreground = "#bac2de";
        number_kilo.foreground = "#a6adc8";
        number_mega.foreground = "#89b4fa";
        number_giga.foreground = "#cba6f7";
        number_huge.foreground = "#cba6f7";
        unit_byte.foreground = "#a6adc8";
        unit_kilo.foreground = "#89dceb";
        unit_mega.foreground = "#cba6f7";
        unit_giga.foreground = "#cba6f7";
        unit_huge.foreground = "#94e2d5";
      };

      users = {
        user_you.foreground = "#cdd6f4";
        user_root.foreground = "#f38ba8";
        user_other.foreground = "#eba0ac";
        group_yours.foreground = "#a6adc8";
        group_other.foreground = "#9399b2";
        group_root.foreground = "#f38ba8";
      };

      links = {
        normal.foreground = "#89b4fa";
        multi_link_file.foreground = "#89b4fa";
      };

      git = {
        new.foreground = "#a6e3a1";
        modified.foreground = "#f9e2af";
        deleted.foreground = "#eba0ac";
        renamed.foreground = "#94e2d5";
        typechange.foreground = "#f5c2e7";
        ignored.foreground = "#7f849c";
        conflicted.foreground = "#fab387";
      };

      git_repo = {
        branch_main.foreground = "#a6adc8";
        branch_other.foreground = "#cba6f7";
        git_clean.foreground = "#a6e3a1";
        git_dirty.foreground = "#eba0ac";
      };

      security_context = {
        colon.foreground = "#6c7086";
        user.foreground = "#7f849c";
        role.foreground = "#cba6f7";
        typ.foreground = "#585b70";
        range.foreground = "#cba6f7";
      };

      file_type = {
        image.foreground = "#f9e2af";
        video.foreground = "#f38ba8";
        music.foreground = "#a6e3a1";
        lossless.foreground = "#94e2d5";
        crypto.foreground = "#7f849c";
        document.foreground = "#cdd6f4";
        compressed.foreground = "#f5c2e7";
        temp.foreground = "#eba0ac";
        compiled.foreground = "#74c7ec";
        source.foreground = "#89b4fa";
      };

      punctuation.foreground = "#6c7086";
      date.foreground = "#f9e2af";
      inode.foreground = "#a6adc8";
      blocks.foreground = "#6c7086";
      header.foreground = "#cdd6f4";
      octal.foreground = "#94e2d5";
      flags.foreground = "#cba6f7";

      symlink_path.foreground = "#89dceb";
      control_char.foreground = "#74c7ec";
      broken_symlink.foreground = "#f38ba8";
      broken_path_overlay.foreground = "#585b70";
    };
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      directory.style = "bold lavender";
      # palette = "catppuccin_mocha";
      # palettes.catppuccin_mocha = {
      #   rosewater = "#f5e0dc";
      #   flamingo = "#f2cdcd";
      #   pink = "#f5c2e7";
      #   mauve = "#cba6f7";
      #   red = "#f38ba8";
      #   maroon = "#eba0ac";
      #   peach = "#fab387";
      #   yellow = "#f9e2af";
      #   green = "#a6e3a1";
      #   teal = "#94e2d5";
      #   sky = "#89dceb";
      #   sapphire = "#74c7ec";
      #   blue = "#89b4fa";
      #   lavender = "#b4befe";
      #   text = "#cdd6f4";
      #   subtext1 = "#bac2de";
      #   subtext0 = "#a6adc8";
      #   overlay2 = "#9399b2";
      #   overlay1 = "#7f849c";
      #   overlay0 = "#6c7086";
      #   surface2 = "#585b70";
      #   surface1 = "#45475a";
      #   surface0 = "#313244";
      #   base = "#1e1e2e";
      #   mantle = "#181825";
      #   crust = "#11111b";
      # };
    };
  };

  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
  };

}

