{ pkgs, ... }:

let
  inherit (pkgs) libnotify papirus-icon-theme;
in
{
  home.packages = [ libnotify ];

  services.dunst = {
    enable = true;

    iconTheme = {
      package = papirus-icon-theme;
      name = "Papirus";
    };

    settings = {
      global = {
        geometry = "1870x5-25+45";
        width = 350;
        separator_height = 5;
        padding = 24;
        horizontal_padding = 24;
        frame_width = 3;
        idle_threshold = 120;
        alignment = "center";
        word_wrap = "yes";
        transparency = 5;
        format = "<b>%s</b>: %b";
        markup = "full";
        min_icon_size = 32;
        max_icon_size = 128;
      };
    };
  };
}
