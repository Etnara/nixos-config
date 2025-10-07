{ pkgs, systemSettings, userSettings, secrets, ... }:

{

  system.stateVersion = "24.11";
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;
  nix.gc = {
    automatic = true;
    options = "--delete-older-than +10";
    dates = "weekly";
  };

  imports = [
    ../../nixos/system
    ../../nixos/gaming
    ../../nixos/virtualisation.nix
  ];

  environment.systemPackages = with pkgs; [
    home-manager
    git
    wget
    unzip
    sshfs
    nvd # Nix diff for number of package updates widget

    # Networking
    net-tools # ifconfig
    dnsutils # nslookup
    whois
    traceroute

    # Forensics
    file
    gdb
  ];

}

