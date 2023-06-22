{ home-manager, stylix, nix-gaming, ... }:

{
  imports = [
    home-manager.nixosModules.home-manager
    stylix.nixosModules.stylix
    nix-gaming.nixosModules.pipewireLowLatency
    ./containers
    ./home
    ./modules
    ./overlays
    ./specializations
    ./src/main.nix
  ];
}
