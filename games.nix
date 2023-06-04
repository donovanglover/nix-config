{ pkgs, lib, ... }:

{
  programs.gamemode.enable = true;

  environment.systemPackages = with pkgs; [
    (pkgs.callPackage ./packages/srb2 { })
    slade
    typespeed
    osu-lazer-bin
  ];

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "osu-lazer-bin"
  ];
}
