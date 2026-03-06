{ pkgs-unstable, lib, ... }:

{

  # MANUAL: nix-store --add-fixed sha256 CiscoPacketTracer_900_Ubuntu_64bit.deb
  environment.systemPackages = [ pkgs-unstable.cisco-packet-tracer_9 ];

  programs.firejail.wrappedBinaries.packettracer9 = {
    executable = lib.getExe pkgs-unstable.cisco-packet-tracer_9;
    extraArgs = [ "--net=none" "--noprofile" ];
  };

}

