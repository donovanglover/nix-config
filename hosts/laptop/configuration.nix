{ self, pkgs, ... }:

let
  inherit (builtins) attrValues;
in
{
  imports = attrValues self.nixosModules;
  nixpkgs.overlays = attrValues self.overlays;
  home-manager.sharedModules = attrValues self.homeManagerModules;
  environment.systemPackages = attrValues self.packages.${pkgs.system};

  modules = {
    hardware = {
      keyboardBinds = true;
      disableLaptopKeyboard = true;
      lidIgnore = true;
      powerIgnore = true;
      bluetooth = true;
    };

    system = {
      mullvad = true;
    };

    desktop = {
      bloat = true;
    };
  };
}
