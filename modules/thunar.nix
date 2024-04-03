{ pkgs, ... }:

let
  inherit (pkgs.xfce) thunar-volman exo;
  inherit (pkgs) glib;
in
{
  programs.thunar = {
    enable = true;
    plugins = [ thunar-volman ];
  };

  services = {
    tumbler.enable = true;
    gvfs.enable = true;
    gnome.gnome-keyring.enable = true;
  };

  environment.systemPackages = [
    exo
    glib
  ];
}
