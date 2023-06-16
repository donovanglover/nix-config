{ pkgs, ... }: {
  stylix.image = ../assets/wallpaper.png;
  stylix.polarity = "dark";
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/monokai.yaml";
  stylix.opacity.terminal = 0.92;

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
      name = "MapleMono";
    };

    emoji = {
      package = pkgs.noto-fonts-emoji;
      name = "Noto Color Emoji";
    };

    sizes = {
      applications = 11;
      desktop = 11;
      popups = 11;
      terminal = 11;
    };
  };
}
