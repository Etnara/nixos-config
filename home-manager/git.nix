{ userSettings, ... }:

{

  programs.git = {
    enable = true;
    userName = userSettings.username;
    userEmail = userSettings.email;
    extraConfig = {
      init.defaultBranch = "master";
      core = {
        editor = "nvim";
      };
      # TODO: Not sure why these don't work
      diff = {
          tool = "nvim -d";
      };
      merge = {
          tool = "nvim -d";
      };
    };
  };

}

