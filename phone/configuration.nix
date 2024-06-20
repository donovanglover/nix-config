{ nix-config, pkgs, lib, ... }:

let
  inherit (lib) singleton mkForce;
  inherit (builtins) attrValues;
in
{
  imports = attrValues {
    inherit (nix-config.nixosModules) system shell desktop hardware;
  };

  nixpkgs.overlays = attrValues nix-config.overlays;

  home-manager.sharedModules = attrValues nix-config.homeManagerModules ++ singleton {
    services.hypridle.enable = mkForce false;

    wayland.windowManager.hyprland.settings = mkForce {
      decoration = {
        drop_shadow = false;
        blur.enabled = false;
      };

      animations.enabled = false;
    };
  };

  environment.systemPackages = attrValues nix-config.packages.${pkgs.system};

  modules = {
    system = {
      hostName = "mobile-nixos";
      stateVersion = "23.11";
      phone = true;
    };

    desktop.phone = true;
    hardware.phone = true;
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
