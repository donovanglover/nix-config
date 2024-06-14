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
    system = {
      phone = true;
      hostName = "mobile-nixos";
      stateVersion = "23.11";
    };
  };
}
