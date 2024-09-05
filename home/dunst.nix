{ config, pkgs, lib, ... }:

let
  inherit (lib) mkForce;

  inherit (config.lib.stylix.colors.withHashtag)
    base0D
    ;
in
{
  services.dunst = {
    enable = true;

    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus";
    };

    settings = {
      global = {
        width = 370;
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

      urgency_low.frame_color = mkForce base0D;
      urgency_normal.frame_color = mkForce base0D;
      urgency_critical.frame_color = mkForce base0D;
    };
  };
}
