{ userSettings, ... }:

{

  programs.git = {
    enable = true;
    lfs.enable = true;
    settings = {
      user.name = userSettings.username;
      user.email = userSettings.email;
      init.defaultBranch = "master";
      pull.rebase = "true";
      push.autoSetupRemote = "true";
      core.editor = "nvim";
      diff.tool = "vimdiff";
      merge.tool = "vimdiff";
    };
  };

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
  };

  programs.bat.enable = true;

}

