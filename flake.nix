{
  inputs = {
    nixpkgs.url = "github:donovanglover/nixpkgs/personal-unstable";

    hyprland = {
      url = "github:hyprwm/Hyprland";
    };

    home-manager = {
      url = "github:donovanglover/home-manager/personal-master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:donovanglover/stylix/personal-master";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };
  };

  outputs = { self, nixpkgs, ... } @ attrs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = attrs;
      modules = [ ./. ];
    };
  };
}
