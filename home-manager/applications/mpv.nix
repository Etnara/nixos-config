{ ... }:

{

  programs.mpv = {
    enable = true;
    profiles = {
      short = {
        profile-cond = "duration < 10";
        loop-file = "inf";
        profile-restore = "copy";
      };
    };
  };

}

