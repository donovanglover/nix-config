{ home-manager, stylix, ... }:

let VARIABLES = import ./src/variables.nix; in {
  imports = [
    home-manager.nixosModules.home-manager
    stylix.nixosModules.stylix
    "${VARIABLES.hostHardwareConfiguration}"
    ./containers
    ./home
    ./modules
    ./overlays
    ./specializations
    ./src/main.nix
  ];
}
