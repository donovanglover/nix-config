{ pkgs, ... }:

{
  environment.pathsToLink = [
    "/share/backgrounds"
    "/share/eww"
  ];

  environment.systemPackages = [
    (pkgs.callPackage ./osu-backgrounds.nix { })
    (pkgs.callPackage ./fluent-icons.nix { })
  ];
}
