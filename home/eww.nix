{ pkgs, ... }:

{
  programs.eww = {
    enable = true;
    package = pkgs.eww-wayland;
    configDir = ../assets/eww;
  };
}
