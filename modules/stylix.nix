{
  nix-config,
  config,
  pkgs,
  ...
}:

let
  inherit (nix-config.packages.${pkgs.system}) aleo-fonts;

  stylix-background = nix-config.packages.${pkgs.system}.stylix-background.override {
    color = config.lib.stylix.colors.base00;
  };

  opacity = 0.95;
  fontSize = 11;
in
{
  imports = with nix-config.inputs.stylix.nixosModules; [ stylix ];

  stylix = {
    enable = true;
    image = "${stylix-background}/wallpaper.png";
    polarity = "dark";

    base16Scheme = {
      system = "base16";
      name = "selenized-black";
      author = "Jan Warchol (https://github.com/jan-warchol/selenized) / adapted to base16 by ali";
      variant = "dark";

      palette = {
        base00 = "181818";
        base01 = "252525";
        base02 = "3b3b3b";
        base03 = "777777";
        base04 = "777777";
        base05 = "b9b9b9";
        base06 = "dedede";
        base07 = "dedede";
        base08 = "ed4a46";
        base09 = "e67f43";
        base0A = "dbb32d";
        base0B = "70b433";
        base0C = "3fc5b7";
        base0D = "368aeb";
        base0E = "a580e2";
        base0F = "eb6eb7";
      };
    };

    opacity = {
      terminal = opacity;
      popups = opacity;
    };

    cursor = {
      package = pkgs.phinger-cursors;
      name = "phinger-cursors";
      size = 24;
    };

    fonts = {
      serif = {
        package = aleo-fonts;
        name = "Aleo";
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
        applications = fontSize;
        desktop = fontSize;
        popups = fontSize;
        terminal = fontSize;
      };
    };
  };
}
