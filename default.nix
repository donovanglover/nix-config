{ home-manager, stylix, ... }:

{
  imports = [
    home-manager.nixosModules.home-manager
    stylix.nixosModules.stylix
    ./containers
    ./hardware
    ./home
    ./modules
    ./overlays
  ];
}
