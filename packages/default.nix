{ pkgs, ... }:

{
  environment.pathsToLink = [
    "/share/backgrounds"
    "/share/eww"
    "/share/thumbnailers"
  ];

  environment.systemPackages = with pkgs; [
    (callPackage ./fluent-icons.nix { })
    (callPackage ./osu-backgrounds.nix { })
    (callPackage ./pnpm-shell-completion.nix { })
    (callPackage ./webp-thumbnailer.nix { })
  ];
}
