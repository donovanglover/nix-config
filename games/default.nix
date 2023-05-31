{ pkgs, ... }:

{
  imports = [
    ./osu
    ./srb2
  ];

  programs.gamemode.enable = true;

  environment.systemPackages = with pkgs; [
    typespeed
  ];
}
