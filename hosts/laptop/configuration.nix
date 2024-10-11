{ nix-config, pkgs, ... }:

let
  inherit (builtins) attrValues;
in
{
  imports = attrValues nix-config.nixosModules;
  nixpkgs.overlays = attrValues nix-config.overlays;
  home-manager.sharedModules = attrValues nix-config.homeModules;
  environment.systemPackages = attrValues nix-config.packages.${pkgs.system};

  modules = {
    hardware = {
      keyboardBinds = true;
      lidIgnore = true;
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
