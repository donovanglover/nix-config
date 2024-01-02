{ pkgs, ... }:

{
  environment.pathsToLink = [
    "/share/backgrounds"
    "/share/eww"
    "/share/thumbnailers"
  ];

  environment.systemPackages = with pkgs; [
    (callPackage ./osu-backgrounds.nix { })
    (callPackage ./candy-icons.nix { })
    (callPackage ./pnpm-shell-completion.nix { })
    (callPackage ./webp-thumbnailer.nix { })
  ];
}
