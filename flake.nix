{
  outputs = { self, nixpkgs, home-manager, stylix, nix-gaming, ... } @ attrs:
    let VARIABLES = import ./src/variables.nix; in {
      formatter."${VARIABLES.system}" = nixpkgs.legacyPackages."${VARIABLES.system}".nixpkgs-fmt;

      nixosConfigurations."${VARIABLES.hostname}" = nixpkgs.lib.nixosSystem {
        system = VARIABLES.system;
        specialArgs = attrs;
        modules = [
          home-manager.nixosModules.home-manager
          stylix.nixosModules.stylix
          nix-gaming.nixosModules.pipewireLowLatency
          ./src/main.nix
        ];
      };
    };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-hyprland-autoname-workspaces.url = "github:donovanglover/nixpkgs/hyprland-autoname-workspaces";
    nixpkgs-srb2.url = "github:donovanglover/nixpkgs/srb2";

    home-manager = {
      url = "github:nix-community/home-manager/master";
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

    nix-gaming.url = "github:fufexan/nix-gaming";

    crystal-flake = {
      url = "github:manveru/crystal-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
