{ pkgs, ... }:

{

  services.mpd = {
    enable = true;
    extraConfig = ''
      auto_update "yes"
      audio_output {
        type "pipewire"
        name "Pipewire Output"
      }
    '';
  };

  programs.rmpc = {
    enable = true;
    # config = '' '';
  };

  home.packages = with pkgs; [
    nicotine-plus
    songrec # Try `shaq` as a cli alternative when it isn't broken
  ];

}


