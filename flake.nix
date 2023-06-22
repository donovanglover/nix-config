{
  inputs = {
    nixpkgs.url = "github:donovanglover/nixpkgs/personal-unstable";
    nix-gaming.url = "github:fufexan/nix-gaming";

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
  };

  outputs = { self, nixpkgs, ... } @ attrs: let VARIABLES = import ./src/variables.nix; in {
    nixosConfigurations."${VARIABLES.hostname}" = nixpkgs.lib.nixosSystem {
      system = VARIABLES.system;
      specialArgs = attrs;
      modules = [
        ./.
      ];
    };
  };
}
