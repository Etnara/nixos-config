{
  description = "Flake of Ren";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    stylix.url = "github:danth/stylix/release-25.11";
    catppuccin.url = "github:catppuccin/nix/release-25.11";
    niri.url = "github:sodiboo/niri-flake";
    quickshell.url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
    quickshell.inputs.nixpkgs.follows = "nixpkgs";
    qml-niri.url = "github:imiric/qml-niri/main";
    qml-niri.inputs.nixpkgs.follows = "nixpkgs";
    qml-niri.inputs.quickshell.follows = "quickshell";
  };

  outputs = { nixpkgs, nixpkgs-unstable, home-manager, stylix, catppuccin, niri, ... }:
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
      LAMPP.enable = false;
    };

    # ----- Secrets ----- #
    secrets = import ./secrets.nix;

    lib = nixpkgs.lib;
    pkgs = import nixpkgs {
      system = systemSettings.architecture;
      config = {
        allowUnfree = true;
        cudaSupport = systemSettings.gpuType == "nvidia";
        rocmSupport = systemSettings.gpuType == "amd";
      };
    };
    pkgs-unstable = import nixpkgs-unstable {
      system = systemSettings.architecture;
      config = {
        allowUnfree = true;
        cudaSupport = systemSettings.gpuType == "nvidia";
        rocmSupport = systemSettings.gpuType == "amd";
      };
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
          inherit pkgs-unstable;
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
          inherit pkgs-unstable;
          inherit qml-niri;
        };
      };
    };

    devShells.${systemSettings.architecture}.default =
      import ./nixos/shell.nix { inherit pkgs; };

  };
}

