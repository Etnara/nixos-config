{ pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    (etterna.overrideAttrs (old: {
      postInstall = (old.postInstall or "") + ''
        cp -r ${./noteskins}/. $out/share/etterna/NoteSkins/dance/
      '';
    }))
  ];

}

