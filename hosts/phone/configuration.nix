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
      hostName = "mobile-nixos";
      stateVersion = "23.11";
      phone = true;
    };

    desktop = {
      phone = true;
      phosh = true;
    };

    hardware.keyboardBinds = true;

    system = {
      mullvad = true;
    };
  };

  environment = {
    sessionVariables = {
      LIBGL_ALWAYS_SOFTWARE = "true";
    };
  };

  programs = {
    calls.enable = true;
  };

  networking = {
    wireless.enable = false;
    wireguard.enable = true;
  };

  services = {
    openssh.enable = true;
  };

  powerManagement.enable = true;
}
