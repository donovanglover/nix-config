{ pkgs, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/installer/cd-dvd/installation-cd-minimal.nix")
  ];

  environment.systemPackages = with pkgs; [
    neovim
  ];

  isoImage.squashfsCompression = "gzip -Xcompression-level 1";
}
