{
  pkgs,
  lib,
  modulesPath,
  nix-config,
  ...
}:

let
  inherit (builtins) attrValues;

  username = "nixos";
in
{
  imports = [
    (modulesPath + "/installer/cd-dvd/installation-cd-minimal.nix")

    nix-config.inputs.home-manager.nixosModules.home-manager
  ] ++ (with nix-config.nixosModules; [
    stylix
    fonts
    desktop
    librewolf
    shell
  ]);

  nixpkgs.overlays = attrValues nix-config.overlays;
  environment.systemPackages = attrValues nix-config.packages.${pkgs.system};

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    sharedModules =
      attrValues nix-config.homeModules
      ++ lib.singleton {
        home.stateVersion = "24.11";
      };

    users.${username}.home = {
      inherit username;

      homeDirectory = "/home/${username}";
    };
  };

  isoImage.squashfsCompression = "gzip -Xcompression-level 1";
}
