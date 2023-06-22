{ home-manager, stylix, nix-gaming, ... }:

let VARIABLES = import ./src/variables.nix; in {
  imports = [
    home-manager.nixosModules.home-manager
    stylix.nixosModules.stylix
    nix-gaming.nixosModules.pipewireLowLatency
    "${VARIABLES.hostHardwareConfiguration}"
    ./containers
    ./home
    ./modules
    ./overlays
    ./specializations
    ./src/main.nix
  ];
}
