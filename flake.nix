{
  description = "Flake of Ren";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    stylix.url = "github:danth/stylix";
    catppuccin.url = "github:catppuccin/nix";
    niri.url = "github:sodiboo/niri-flake";
  };

  outputs = { nixpkgs, home-manager, stylix, catppuccin, niri, ... }:
  let
    # ---- SYSTEM SETTINGS ---- #
    systemSettings = {
      architecture = "x86_64-linux";
      hostname = "";
      profile = "base";
      timezone = "America/New_York"; # "America/New_York" or "Europe/London" or "Europe/Brussels"
      locale = "en_GB.UTF-8";
      monitors = [ "DP-1" ]; # hyprctl monitors list
      HiDPI = false;
      cpuType = ""; # "intel" or "amd" or "qemu"
      gpuType = ""; # "nvidia" or "amd" or "qemu"
    };

    # ----- USER SETTINGS ----- #
    userSettings = {
      username = "ren";
      name = "Ren";
      email = "zakbutt18@gmail.com";
      editor = "nvim";
      term = "kitty";
      browser = "librewolf";
      wm = "hyprland";
      LAMPP.enable = false;
    };

    # ----- Secrets ----- #
    secrets = import ./secrets.nix;

    lib = nixpkgs.lib;
    pkgs = import nixpkgs {
      system = systemSettings.architecture;
      config.allowUnfree = true;
    };
  in
  {

    nixpkgs.overlays = [ niri.overlays.niri ];

    nixosConfigurations = {
      ${systemSettings.hostname} = lib.nixosSystem {
        system = systemSettings.architecture;
        modules = [
          ./profiles/${systemSettings.profile}/configuration.nix
          catppuccin.nixosModules.catppuccin
          niri.nixosModules.niri
        ];
        specialArgs = {
          inherit systemSettings;
          inherit userSettings;
          inherit secrets;
        };
      };
    };

    homeConfigurations = {
      ${userSettings.username} = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./profiles/base/home.nix
          stylix.homeModules.stylix
          catppuccin.homeModules.catppuccin
          niri.homeModules.niri
        ];
        extraSpecialArgs = {
          inherit systemSettings;
          inherit userSettings;
          inherit secrets;
        };
      };
    };

    devShells.${systemSettings.architecture}.default =
      import ./nixos/shell.nix { inherit pkgs; };

  };
}

