{ pkgs, ... }:

{
  fonts = {
    enableDefaultPackages = false;

    packages = with pkgs; [
      aleo-fonts
      noto-fonts
      noto-fonts-cjk-serif
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      maple-mono
      font-awesome
      nerd-fonts.noto
      kanji-stroke-order-font
      liberation_ttf
    ];

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
