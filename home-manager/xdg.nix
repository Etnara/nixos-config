{ userSettings, ... }:

let
  homeDirectory = "/home/${userSettings.username}";
in
{

  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
      desktop = "${homeDirectory}/Desktop";
      documents = "${homeDirectory}/Documents";
      download = "${homeDirectory}/Downloads";
      pictures =  "${homeDirectory}/Pictures";
      videos =  "${homeDirectory}/Videos";
      music = null;
      templates = null;
      publicShare = null;
    };
    mime.enable = true;
    mimeApps = {
      enable = true;
      defaultApplications = {
        "text/plain" = "nvim.desktop";
        "application/json" = "nvim.desktop";
        "application/pdf" = "librewolf.desktop";
        # "audio/mpeg"
        "video/mp4" = "mpv.desktop";
        "video/x-matroska" = "mpv.desktop";
        "image/png" = "feh.desktop";
        "image/jpeg" = "feh.desktop";
        "image/webp" = "feh.desktop";
      };
    };
  };

  systemd.user.tmpfiles.rules = [
    # Type Path Mode User Group Age Arguments
    "d ${homeDirectory}/Videos/!Raw 0755 - - - -"
    "d ${homeDirectory}/Pictures/Art 0755 - - - -"
    "d ${homeDirectory}/Pictures/Memes 0755 - - - -"
    "d ${homeDirectory}/Pictures/Screenshots 0755 - - - -"
    "d ${homeDirectory}/Documents/Games 0755 - - - -"
    "d ${homeDirectory}/Documents/Git 0755 - - - -"
    "d ${homeDirectory}/Documents/VMs 0755 - - - -"
    "d ${homeDirectory}/.remote 0755 - - - -"
  ];

}

