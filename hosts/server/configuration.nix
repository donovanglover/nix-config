{ pkgs, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/virtualisation/digital-ocean-image.nix")
  ];

  environment.systemPackages = [ pkgs.neovim ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
}
