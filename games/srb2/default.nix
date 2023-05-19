{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    (pkgs.callPackage ./package {})
    slade
  ];
}
