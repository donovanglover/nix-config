{ lib, pkgs, ... }:

let
  inherit (lib) singleton;
in
{
  home-manager.sharedModules = singleton {
    services = {
      picom = rec {
        enable = true;
        backend = "glx";

        vSync = true;
        fade = true;
        shadow = true;

        fadeDelta = 5;

        fadeExclude = [
          "window_type = 'menu'"
          "window_type = 'dropdown_menu'"
          "window_type = 'popup_menu'"
          "window_type = 'tooltip'"
        ];

        shadowExclude = fadeExclude;

        settings = {
          blur = {
            method = "dual_kawase";
            size = 10;
          };
        };
      };

      dunst = {
        enable = true;

        iconTheme = {
          package = pkgs.papirus-icon-theme;
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
    };
  };

  services = {
    xserver = {
      displayManager.startx.enable = true;
      windowManager.dwm.enable = true;
    };

    libinput = {
      touchpad = {
        naturalScrolling = true;
        accelProfile = "flat";
      };

      mouse = {
        accelProfile = "flat";
      };
    };
  };
}
