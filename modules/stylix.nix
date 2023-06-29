{ pkgs, ... }:

let
  theme = "monokai";
  opacity = 0.92;
  font-size = 11;
in
{
  stylix.image = ../assets/wallpaper.png;
  stylix.polarity = "dark";
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/${theme}.yaml";

  stylix.opacity = {
    terminal = opacity;
    popups = opacity;
  };

  stylix.fonts = {
    serif = {
      package = pkgs.noto-fonts-cjk-sans;
      name = "Noto Sans CJK JP";
    };

    sansSerif = {
      package = pkgs.noto-fonts-cjk-sans;
      name = "Noto Sans CJK JP";
    };

    monospace = {
      package = pkgs.maple-mono;
      name = "Maple Mono";
    };

    emoji = {
      package = pkgs.noto-fonts-emoji;
      name = "Noto Color Emoji";
    };

    sizes = {
      applications = font-size;
      desktop = font-size;
      popups = font-size;
      terminal = font-size;
    };
  };
}
