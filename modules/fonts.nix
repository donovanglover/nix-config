{ nix-config, pkgs, ... }:

let
  inherit (nix-config.packages.${pkgs.system}) aleo-fonts;
in
{
  fonts = {
    enableDefaultPackages = false;

    packages =
      [
        aleo-fonts
      ]
      ++ (with pkgs; [
        noto-fonts
        noto-fonts-cjk-serif
        noto-fonts-cjk-sans
        noto-fonts-emoji
        maple-mono
        font-awesome
        (nerdfonts.override { fonts = [ "Noto" ]; })
        kanji-stroke-order-font
        liberation_ttf
      ]);

    fontconfig = {
      defaultFonts = {
        serif = [
          "Noto Serif CJK JP"
          "Noto Serif"
        ];

        sansSerif = [
          "Noto Sans CJK JP"
          "Noto Sans"
        ];

        monospace = [
          "Noto Sans Mono CJK JP"
          "Noto Sans Mono"
        ];
      };

      allowBitmaps = false;
    };
  };
}
