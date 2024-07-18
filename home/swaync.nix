{ pkgs, ... }:

let
  inherit (pkgs) libnotify;
in
{
  home.packages = [ libnotify ];

  services.swaync = {
    enable = true;
  };
}
