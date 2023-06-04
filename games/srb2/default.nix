{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    (pkgs.callPackage ../../packages/srb2 { })
    slade
  ];
}
