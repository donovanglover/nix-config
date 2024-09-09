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

  i18n.inputMethod.enable = mkForce false;

  programs = {
    cdemu.enable = mkForce false;
    hyprland.enable = mkForce false;
    thunar.enable = mkForce false;
  };

  services = {
    udisks2.enable = mkForce false;
    pipewire.enable = mkForce false;
    greetd.enable = mkForce false;
  };

  boot = {
    binfmt.emulatedSystems = mkForce [ ];
    loader.systemd-boot.enable = mkIf (pkgs.system == "aarch64-linux") (mkForce false);
  };

  hardware.graphics.enable32Bit = mkForce false;
}
