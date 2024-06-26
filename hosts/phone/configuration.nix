{ self, pkgs, ... }:

let
  inherit (builtins) attrValues;
in
{
  imports = attrValues self.nixosModules;

  nixpkgs.overlays = attrValues {
    inherit (self.overlays) phinger-cursors;
  };

  home-manager.sharedModules = attrValues {
    inherit (self.homeManagerModules)
      eza
      fcitx
      fish
      git
      gpg
      gtk
      htop
      librewolf
      neovim
      starship
      thunar
      xdg-user-dirs
      xresources
      ;
  };

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
