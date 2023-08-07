{ pkgs, ... }:

{
  environment.pathsToLink = [
    "/share/backgrounds"
  ];

  environment.systemPackages = [
    (pkgs.callPackage ./osu-backgrounds.nix { })
  ];
}
