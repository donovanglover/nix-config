{ pkgs, ... }:

let
  theme = "monokai";
  opacity = 0.95;
  font-size = 11;
in
{
  stylix = {
    image = ../assets/wallpaper.png;
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/${theme}.yaml";

    opacity = {
      terminal = opacity;
      popups = opacity;
    };

    cursor = with pkgs; {
      package = phinger-cursors;
      name = "phinger-cursors";
      size = 24;
    };

    fonts = with pkgs; {
      serif = {
        package = (callPackage ../packages/aleo-fonts.nix { });
        name = "Aleo";
      };

      sansSerif = {
        package = noto-fonts-cjk-sans;
        name = "Noto Sans CJK JP";
      };

      monospace = {
        package = maple-mono;
        name = "Maple Mono";
      };

      emoji = {
        package = noto-fonts-emoji;
        name = "Noto Color Emoji";
      };

      sizes = {
        applications = font-size;
        desktop = font-size;
        popups = font-size;
        terminal = font-size;
      };
    };
  };
}
