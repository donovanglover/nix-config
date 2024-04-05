{ self, pkgs, ... }:

let
  inherit (builtins) attrValues;
in
{
  imports = attrValues self.nixosModules ++ [
    ./hardware/laptop.nix
  ];

  nixpkgs.overlays = attrValues self.overlays;
  home-manager.sharedModules = attrValues self.homeManagerModules;
  environment.systemPackages = attrValues self.packages.${pkgs.system};

  environment.pathsToLink = [
    "/share/backgrounds"
    "/share/eww"
    "/share/thumbnailers"
    "/share/fonts"
  ];

  modules = {
    hardware = {
      disableLaptopKeyboard = true;
      lidIgnore = true;
      powerIgnore = true;
    };

    networking = {
      mullvad = true;
    };

    desktop = {
      japanese = true;
      bloat = true;
      wine = true;
    };
  };
}
