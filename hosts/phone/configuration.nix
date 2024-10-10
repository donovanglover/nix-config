{
  self,
  pkgs,
  lib,
  ...
}:

let
  inherit (lib) mkIf mkForce;
  inherit (builtins) attrValues;
in
{
  imports = attrValues self.nixosModules;

  nixpkgs = {
    overlays = with self.overlays; [ phinger-cursors ];

    config.permittedInsecurePackages = [
      "olm-3.2.16"
    ];
  };

  home-manager.sharedModules = with self.homeModules; [
    dconf
    eza
    fish
    git
    gpg
    gtk
    htop
    kitty
    librewolf
    neovim
    starship
    xdg-user-dirs
    xresources
  ];

  modules = {
    system = {
      hostName = "mobile-nixos";
      stateVersion = "23.11";
      mullvad = true;
    };

    hardware.keyboardBinds = true;

    phone.enable = true;
  };
}
