{ pkgs, ... }:

{
  fonts = {
    enableDefaultFonts = false;

    fonts = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-emoji
      maple-mono
      font-awesome
      nerdfonts
      kanji-stroke-order-font
      liberation_ttf
    ];

    fontconfig = {
      defaultFonts = {
        serif = [ "Noto Serif CJK JP" "Noto Serif" ];
        sansSerif = [ "Noto Sans CJK JP" "Noto Sans" ];
        monospace = [ "Noto Mono CJK JP" "Noto Mono" ];
      };

      allowBitmaps = false;
      hinting.style = "hintfull";
    };
  };
}
