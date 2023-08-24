{ pkgs, ... }:

{
  environment.pathsToLink = [
    "/share/backgrounds"
    "/share/eww"
    "/share/thumbnailers"
  ];

  environment.systemPackages = [
    (pkgs.callPackage ./osu-backgrounds.nix { })
    (pkgs.callPackage ./fluent-icons.nix { })
    (pkgs.callPackage ./webp-thumbnailer.nix { })
  ];
}
