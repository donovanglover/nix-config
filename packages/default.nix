{ pkgs, ... }:

{
  environment.pathsToLink = [
    "/share/backgrounds"
    "/share/eww"
    "/share/thumbnailers"
  ];

  environment.systemPackages = with pkgs; [
    (callPackage ./osu-backgrounds.nix { })
    (callPackage ./fluent-icons.nix { })
    (callPackage ./webp-thumbnailer.nix { })
  ];
}
