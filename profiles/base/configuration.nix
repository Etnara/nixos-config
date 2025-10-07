{ pkgs, systemSettings, userSettings, secrets, ... }:

{
  imports = [
    ../../nixos/hardware
    ../../nixos/boot.nix
    ../../nixos/fonts.nix
    ../../nixos/hyprland.nix
    ../../nixos/gaming
    ../../nixos/virtualisation.nix
    ../../nixos/zsh.nix
    ../../nixos/timezone-locale.nix
    ../../nixos/users.nix
  ];

  system.stateVersion = "24.11";
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;
  nix.gc = {
    automatic = true;
    options = "--delete-older-than +10";
    dates = "weekly";
  };

  environment.systemPackages = with pkgs; [
    home-manager
    wget
    unzip
    git
    nvd # Nix diff for number of package updates widget
    sshfs

    # Networking
    net-tools # ifconfig
    dnsutils # nslookup
    whois
    traceroute

    # Forensics
    file
    gdb

    # Debugging
    # vulkan-tools
  ];

}

