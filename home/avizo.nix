{ config, lib, ... }:

let
  inherit (config.lib.stylix.colors)
    base01-rgb-r
    base01-rgb-g
    base01-rgb-b
    base02-rgb-r
    base02-rgb-g
    base02-rgb-b
    base05-rgb-r
    base05-rgb-g
    base05-rgb-b
    ;
in
{
  services.avizo = {
    enable = true;

    settings.default = {
      time = 1;
      image-opacity = lib.mkForce 1;
      height = 190;
      padding = 10;
      y-offset = 0.5;
      border-width = 0;
      block-height = 10;
      block-spacing = 0;
      fade-in = 0.2;
      fade-out = 0.2;
      background = lib.mkForce "rgba(${base01-rgb-r}, ${base01-rgb-g}, ${base01-rgb-b}, 1)";
      border-color = lib.mkForce "rgba(${base01-rgb-r}, ${base01-rgb-g}, ${base01-rgb-b}, 1)";
      bar-fg-color = lib.mkForce "rgba(${base05-rgb-r}, ${base05-rgb-g}, ${base05-rgb-b}, 1)";
      bar-bg-color = lib.mkForce "rgba(${base02-rgb-r}, ${base02-rgb-g}, ${base02-rgb-b}, 1)";
    };
  };
}
