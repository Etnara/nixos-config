{
  description = "Flake of Ren";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    stylix.url = "github:danth/stylix";
    catppuccin.url = "github:catppuccin/nix";
  };

  outputs = { nixpkgs, home-manager, stylix, catppuccin, ... }:
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
    };

    # ----- Secrets ----- #
    secrets = import ./secrets.nix;

    lib = nixpkgs.lib;
    pkgs = nixpkgs.legacyPackages.${systemSettings.architecture};
  in
  {

    nixosConfigurations = {
      ${systemSettings.hostname} = lib.nixosSystem {
        system = systemSettings.architecture;
        modules = [
          ./profiles/${systemSettings.profile}/configuration.nix
          catppuccin.nixosModules.catppuccin
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

