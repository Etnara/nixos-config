{ ... }:

{
  
  programs.keepassxc = {
    enable = true;
    # MANUAL: Configure KeePassXC
    # KeePassXC refuses to create the file in the browser location when configured through home-manager
    # settings = {
    #   General = {
    #     BackupBeforeSave = true;
    #     HideWindowOnCopy = true;
    #     MinimizeAfterUnlock = true;
    #   };
    #   Browser = {
    #     Enabled = true;
    #     UseCustomBrowser = true;
    #     CustomBrowserLocation = "~/.librewolf/native-messaging-hosts";
    #   };
    #   GUI = {
    #     HidePasswords = true;
    #     MinimizeOnClose = true;
    #     MinimizeOnStartup = true;
    #     ShowTrayIcon = true;
    #     ToolButtonStyle = 2;
    #     TrayIconAppearance = "colorful";
    #   };
    #   Security.LockDatabaseIdle = true;
    # };
  };

}

