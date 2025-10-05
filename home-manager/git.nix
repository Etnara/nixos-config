{ userSettings, ... }:

{

  programs.git = {
    enable = true;
    userName = userSettings.username;
    userEmail = userSettings.email;
    extraConfig = {
      init.defaultBranch = "master";
      core.editor = "nvim";
      diff.tool = "vimdiff";
      merge.tool = "vimdiff";
    };
  };

}

