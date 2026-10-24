{ pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    (unnamed-sdvx-clone.overrideAttrs (old: {
      postInstall = (old.postInstall or "") + ''
        cp -r ${./skins}/. $out/bin/skins/
      '';
    }))
  ];

}

