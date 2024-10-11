{ nix-config, ... }:

let
  inherit (builtins) attrValues;
in
{
  imports = attrValues nix-config.nixosModules ++ attrValues nix-config.inputs.mobile-nixos.nixosModules;

  nixpkgs = {
    overlays = with nix-config.overlays; [ phinger-cursors ];

    config.permittedInsecurePackages = [
      "olm-3.2.16"
    ];
  };

  home-manager.sharedModules = with nix-config.homeModules; [
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

  mobile.beautification = {
    silentBoot = true;
    splash = true;
  };
}
