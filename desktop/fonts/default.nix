{ pkgs, ... }:

{
  fonts = {
    enableDefaultFonts = true;
    fonts = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-emoji
      maple-mono
      maple-mono-NF
      font-awesome
      nerdfonts
    ];
    fontconfig = {
      defaultFonts = {
        serif = [ "Noto Serif CJK JP" "Noto Serif" ];
        sansSerif = [ "Noto Sans CJK JP" "Noto Sans" ];
        monospace = [ "Noto Mono CJK JP" "Noto Mono" ];
      };
      allowBitmaps = false;
      hinting = { style = "hintfull"; };
    };
  };
}
