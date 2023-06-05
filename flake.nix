{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };

    hypr-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-gaming = {
      url = "github:fufexan/nix-gaming";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, hyprland, stylix, nix-gaming, ... }@attrs: let
    VARIABLES = import ./variables.nix;
  in {
    nixosConfigurations."${VARIABLES.HOSTNAME}" = nixpkgs.lib.nixosSystem {
      system = VARIABLES.SYSTEM;
      specialArgs = attrs;
      modules = [
        home-manager.nixosModules.home-manager
        hyprland.nixosModules.default
        stylix.nixosModules.stylix
        nix-gaming.nixosModules.pipewireLowLatency
        ./common.nix
        ./hardware-configuration.nix
      ];
    };
  };
}
