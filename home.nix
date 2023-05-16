{ config, lib, nixpkgs, pkgs, home-manager, hyprland, ... }: {
  imports = [ home-manager.nixosModule ];
  home-manager.useGlobalPkgs = true;
  home-manager.sharedModules = [{
    home.stateVersion = "22.11";
  }];
}
