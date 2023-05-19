{ pkgs, ... }:

{
  imports = [
    ./editorconfig
    ./nix
    ./npm
    ./rust
  ];

  environment.systemPackages = with pkgs; [
    marksman
  ];
}
