{ userSettings, ... }:

{

  programs.git = {
    enable = true;
    delta.enable = true;
    userName = userSettings.username;
    userEmail = userSettings.email;
    extraConfig = {
      init.defaultBranch = "master";
      pull.rebase = "true";
      core.editor = "nvim";
      diff.tool = "vimdiff";
      merge.tool = "vimdiff";
    };
  };

  programs.bat.enable = true;

}

