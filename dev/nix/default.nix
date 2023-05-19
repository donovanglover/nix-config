{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    nil
    nixfmt
    nixos-generators
  ];
}
