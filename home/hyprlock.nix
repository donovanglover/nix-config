{ lib, ... }:

let
  inherit (lib) mkForce;
in
{
  programs.hyprlock = {
    enable = true;

    settings = {
      general = {
        hide_cursor = true;
        grace = 2;
      };

      background = mkForce {
        color = "rgba(25, 20, 20, 1.0)";
        path = "screenshot";
        blur_passes = 2;
        brightness = 0.5;
      };

      label = {
        text = "パスワードをご入力ください";
        color = "rgba(222, 222, 222, 1.0)";
        font_size = 50;
        font_family = "Noto Sans CJK JP";
        position = "0, 70";
        halign = "center";
        valign = "center";
      };

      input-field = {
        size = "50, 50";
        dots_size = 0.33;
        dots_spacing = 0.15;
        outer_color = mkForce "rgba(25, 20, 20, 0)";
        inner_color = mkForce "rgba(25, 20, 20, 0)";
        font_color = mkForce "rgba(222, 222, 222, 1.0)";
        placeholder_text = "パスワード";
      };
    };
  };
}
