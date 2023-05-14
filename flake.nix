{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    hyprland.url = "github:hyprwm/Hyprland";
    stylix.url = "github:danth/stylix";
    stylix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, hyprland, stylix, ... }@attrs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = attrs;
      modules = [
        ./configuration.nix
        ./home.nix
        hyprland.nixosModules.default
        { programs.hyprland.enable = true; }
        stylix.nixosModules.stylix
        home-manager.nixosModules.home-manager
      ];
    };
  };
}
