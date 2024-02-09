{ pkgs, ... }:

{
  environment.pathsToLink = [
    "/share/backgrounds"
    "/share/eww"
    "/share/thumbnailers"
    "/share/fonts"
  ];

  environment.systemPackages = with pkgs; [
    (callPackage ./aleo-fonts.nix { })
    (callPackage ./fluent-icons.nix { })
    (callPackage ./osu-backgrounds.nix { })
    (callPackage ./pnpm-shell-completion.nix { })
    (callPackage ./webp-thumbnailer.nix { })
  ];
}
