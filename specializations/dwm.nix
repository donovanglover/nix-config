{ lib, pkgs, ... }:

let
  inherit (lib) singleton;

  osu-backgrounds = pkgs.callPackage ../packages/osu-backgrounds.nix { };
in
{
  home-manager.sharedModules = singleton {
    home.packages = with pkgs; [
      feh
    ];

    home.file.".xinitrc" = {
      executable = true;
      text = # bash
        ''
          #!/usr/bin/env sh

          export XDG_SESSION_TYPE=x11
          export GDK_BACKEND=x11
          export XDG_CURRENT_DESKTOP=dwm
          export GTK_IM_MODULE=fcitx
          export QT_IM_MODULE=fcitx
          export XMODIFIERS=@im=fcitx
          export SDL_IM_MODULE=fcitx
          export GLFW_IM_MODULE=ibus

          xrdb -merge ~/.Xresources
          xset r rate 300 50
          feh --bg-fill "$(fish -c 'random choice (fd . ${osu-backgrounds}/2024-07-15-Aerial-Antics-Art-Contest-All-Entries --follow -e jpg -e png)')" &

          while true; do
            xsetroot -name "$(date +"%F %R")"
            sleep 1m
          done &

          picom --backend glx --vsync --shadow --fading --blur-background --blur-method dual_kawase --blur-size 10 --daemon

          fcitx5 &

          while true; do
            dwm >/dev/null 2>&1
          done
        '';
    };

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
