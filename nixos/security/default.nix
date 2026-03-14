{ pkgs, ... }:

{

  imports = [
    ./wireshark.nix
    ./packet-tracer.nix
  ];

  environment.systemPackages = with pkgs; [
    # Networking
    net-tools # ifconfig
    dnsutils # nslookup
    whois
    traceroute
    nmap

    # Benchmarking
    flent
    netperf

    # Forensics
    file
    gdb
  ];

  programs.firejail.enable = true;

}

