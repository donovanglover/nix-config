{ pkgs, ... }:

{
  imports = [
    ./osu
    ./srb2
  ];

  environment.systemPackages = with pkgs; [
    typespeed
  ];
}
