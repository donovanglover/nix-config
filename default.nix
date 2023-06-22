{ home-manager, stylix, lib, ... }:

{
  imports = [
    home-manager.nixosModules.home-manager
    stylix.nixosModules.stylix
    ./containers
    ./hardware
    ./home
    ./modules
    ./overlays
    ./specializations
    ./src/main.nix
  ];

  options.variables = {
    hostname = lib.mkOption { default = "nixos"; };
    hostHardwareConfiguration = lib.mkOption { default = ./hardware/laptop.nix; };
    stateVersion = lib.mkOption { default = "22.11"; };
    username = lib.mkOption { default = "user"; };
    defaultBrowser = lib.mkOption { default = "librewolf"; };
  };
}
