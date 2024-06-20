{ nix-config, pkgs, ... }:

let
  inherit (builtins) attrValues;
in
{
  imports = attrValues {
    inherit (nix-config.nixosModules) system shell desktop hardware;
  };

  nixpkgs.overlays = attrValues nix-config.overlays;

  home-manager.sharedModules = attrValues nix-config.homeManagerModules;

  environment.systemPackages = attrValues nix-config.packages.${pkgs.system};

  modules = {
    system = {
      hostName = "mobile-nixos";
      stateVersion = "23.11";
      phone = true;
    };

    desktop.phone = true;

    hardware = {
      keyboardBinds = true;
      bluetooth = true;
      phone = true;
      sensor = true;
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
