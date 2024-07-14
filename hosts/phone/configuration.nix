{ self, pkgs, lib, ... }:

let
  inherit (builtins) attrValues;
in
{
  imports = attrValues self.nixosModules;

  nixpkgs.overlays = attrValues {
    inherit (self.overlays)
      phinger-cursors
      hyprland
      ;
  };

  home-manager.sharedModules = attrValues {
    inherit (self.homeManagerModules)
      dunst
      eww
      eza
      fcitx
      fish
      git
      gpg
      gtk
      htop
      hyprland
      ironbar
      kitty
      librewolf
      mpv
      ncmpcpp
      neovim
      starship
      swayosd
      thunar
      xdg-user-dirs
      xresources
      ;
  };

  environment.systemPackages = attrValues {
    inherit (self.packages.${pkgs.system})
      webp-thumbnailer
      ;
  };

  modules = {
    system = {
      hostName = "mobile-nixos";
      stateVersion = "23.11";
      phone = true;
    };

    desktop = {
      phone = true;
    };

    hardware.keyboardBinds = true;

    system = {
      mullvad = true;
    };
  };

  programs = {
    calls.enable = true;
  };

  services.pipewire.enable = lib.mkForce false;

  networking = {
    wireless.enable = false;
    wireguard.enable = true;
  };

  services = {
    openssh.enable = true;
  };

  powerManagement = {
    enable = true;

    cpufreq = rec {
      min = 648000;
      max = min;
    };

    cpuFreqGovernor = "powersave";
  };
}
