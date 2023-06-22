{ home-manager, stylix, lib, ... }:

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

  options.variables = {
    hostname = lib.mkOption { default = "nixos"; };
    timezone = lib.mkOption { default = "America/New_York"; };
    hostHardwareConfiguration = lib.mkOption { default = ./hardware/laptop.nix; };
    stateVersion = lib.mkOption { default = "22.11"; };
    defaultLocale = lib.mkOption { default = "ja_JP.UTF-8"; };
    supportedLocales = lib.mkOption { default = [ "ja_JP.UTF-8/UTF-8" "en_US.UTF-8/UTF-8" "fr_FR.UTF-8/UTF-8" ]; };
    username = lib.mkOption { default = "user"; };
    defaultBrowser = lib.mkOption { default = "librewolf"; };
  };
}
