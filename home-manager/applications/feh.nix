{ ... }:

{

  programs.feh = {
    enable = true;
    keybindings = {
      prev_img = ["k"];
      next_img = ["j"];
    };
    themes = {
      feh = [
        "--scale-down"
        "--image-bg"
        "#1e1e2e"
      ];
    };
  };

}

