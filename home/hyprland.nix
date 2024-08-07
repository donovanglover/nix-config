{
  pkgs,
  lib,
  vars,
  ...
}:

let
  inherit (pkgs) polkit_gnome callPackage;
  inherit (lib) mkForce;
  inherit (vars) notifySend;

  opacity = "0.95";
  super = "SUPER";

  osu-backgrounds = callPackage ../packages/osu-backgrounds.nix { };

  gapsScript = "hypr/gaps.fish";
  randomBackgroundScript = "hypr/random-bg.fish";
  swapBackgroundScript = "hypr/swap-bg.fish";
  setBackgroundScript = "hypr/set-bg.fish";
  monitorScript = "hypr/monitor-script.fish";
in
{
  home.packages = with pkgs; [
    hyprdim
    hyprnome
    hyprshade
    swww
    grimblast
    brightnessctl
    playerctl
    libnotify
    mpvpaper
    lnch
    wev
    icoextract
    thud
    activate-linux
    wf-recorder
    lutgen
  ];

  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      env = [
        "BROWSER,librewolf"
        "QT_IM_MODULE,fcitx"
        "XMODIFIERS,@im=fcitx"
        "SDL_IM_MODULE,fcitx"
        "GLFW_IM_MODULE,ibus"
        "SWWW_TRANSITION,grow"
        "SWWW_TRANSITION_STEP,200"
        "SWWW_TRANSITION_DURATION,1.5"
        "SWWW_TRANSITION_FPS,240"
        "SWWW_TRANSITION_WAVE,80,40"
        "QT_AUTO_SCREEN_SCALE_FACTOR,1"
        "QT_QPA_PLATFORM,wayland;xcb"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
        "QT_QPA_PLATFORMTHEME,qt5ct"
        "QT_STYLE_OVERRIDE,kvantum"
      ];

      monitor = [
        ",preferred,auto,1"
        "eDP-1,preferred,auto-left,1"
        "HDMI-A-1,highrr,auto-right,1"
      ];

      exec-once = [
        "sleep 0.1; swww-daemon"
        "wpctl set-volume @DEFAULT_AUDIO_SINK@ 20%"
        "ironbar"
        "fcitx5"
        "mpdris2-rs"
        "hyprctl dispatch workspace 5000000"
        "${polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"
        "hyprdim --no-dim-when-only --persist --ignore-leaving-special --dialog-dim"
        "sleep 1 && eww open desktop-icons"
        "~/.config/${randomBackgroundScript}"
      ];

      input = {
        kb_layout = "us";
        repeat_rate = 50;
        repeat_delay = 300;

        accel_profile = "flat";
        follow_mouse = 1;
        sensitivity = 0;
        mouse_refocus = false;

        touchpad = {
          natural_scroll = true;
          disable_while_typing = false;
        };
      };

      general = {
        gaps_in = 0;
        gaps_out = 0;
        border_size = 0;
        layout = "master";
      };

      decoration = {
        rounding = 0;
        drop_shadow = true;
        shadow_range = 30;
        shadow_render_power = 3;

        blur = {
          enabled = true;
          size = 4;
          passes = 2;
        };
      };

      animations = {
        enabled = true;
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default, slidevert"
          "specialWorkspace, 1, 6, default, fade"
        ];
      };

      dwindle = {
        preserve_split = true;
        special_scale_factor = 1;
      };

      master = {
        new_on_top = false;
        mfact = 0.65;
        special_scale_factor = 1;
      };

      gestures = {
        workspace_swipe = true;
      };

      device = [
        {
          name = "synps/2-synaptics-touchpad";
          sensitivity = 0.75;
          accel_profile = "flat";
          natural_scroll = true;
          disable_while_typing = false;
        }
        {
          name = "tpps/2-elan-trackpoint";
          sensitivity = 0.5;
          accel_profile = "flat";
        }
      ];

      binds = {
        allow_workspace_cycles = true;
      };

      layerrule = [
        "blur,ironbar"
        "blur,rofi"
        "blur,notifications"
      ];

      windowrulev2 = [
        "nomaxsize,class:^(winecfg\.exe|osu\.exe)$"
        "opaque,class:^(kitty)$"
        "noblur,class:^(kitty)$"
        "nodim,title:^(Picture-in-Picture|ピクチャーインピクチャー)$"
        "nodim,class:^(mpv)$"
        "tile,class:^(.qemu-system-x86_64-wrapped)$"
        "opacity ${opacity} ${opacity},class:^(thunar)$"
        "float,class:^(librewolf|Mullvad Browser)$"
        "center 1,class:^(librewolf|Mullvad Browser)$"
      ];

      misc = {
        disable_hyprland_logo = true;
        animate_manual_resizes = true;
        animate_mouse_windowdragging = true;
        disable_autoreload = true;
        new_window_takes_over_fullscreen = 1;
        initial_workspace_tracking = 0;
      };

      bind = [
        "${super}_SHIFT, Return, exec, kitty"
        "${super}_SHIFT, Q, killactive"
        "${super}, W, exec, ~/.config/${randomBackgroundScript}"
        "${super}_SHIFT, W, exec, ~/.config/${swapBackgroundScript}"
        "${super}, P, exec, notify-send --icon=$(grimblast save screen) Screenshot Captured."
        ", Print, exec, grimblast --freeze copy area"
        "${super}_ALT, delete, exit"
        "${super}, V, togglefloating"
        "${super}, B, centerwindow"
        "${super}, U, exec, ~/.config/${gapsScript}"
        "${super}, X, pin"
        "${super}, F, fullscreen"
        "${super}, Tab, exec, hyprctl dispatch overview:toggle"
        "${super}, S, swapactiveworkspaces, 0 1"
        "${super}_SHIFT, S, movetoworkspace, special"
        "${super}_SHIFT, A, exec, killall activate-linux || activate-linux -s 1.15 -x 412 -y 120 -c 1-1-1-0.05"
        "${super}, O, exec, killall .ironbar-wrapper inotifywait pactl || ironbar"
        "${super}_SHIFT, O, exec, eww close overlay || eww open overlay"
        ''${super}, comma, exec, playerctl -p mpv position "5-" && ${notifySend} "Minus 5 seconds" "$(playerctl -p mpv position)"''
        ''${super}, period, exec, playerctl -p mpv position "5+" && ${notifySend} "Plus 5 seconds" "$(playerctl -p mpv position)"''
        ''${super}_SHIFT, comma, exec, playerctl -p mpv previous && ${notifySend} "Previous track" "$(playerctl -p mpv metadata xesam:title)"''
        ''${super}_SHIFT, period, exec, playerctl -p mpv next && ${notifySend} "Next track" "$(playerctl -p mpv metadata xesam:title)"''
        ''${super}, slash, exec, playerctl -p mpv play-pause && ${notifySend} "mpv" "$(playerctl -p mpv status)"''
        "${super}, M, focusmonitor, +1"
        "${super}_SHIFT, M, focusmonitor, -1"

        "${super}, Return, layoutmsg, swapwithmaster master"
        "${super}, J, layoutmsg, cyclenext"
        "${super}, K, layoutmsg, cycleprev"
        "${super}_SHIFT, J, layoutmsg, swapnext"
        "${super}_SHIFT, K, layoutmsg, swapprev"
        "${super}, C, splitratio, exact 0.80"
        "${super}, C, layoutmsg, orientationtop"
        "${super}_SHIFT, C, splitratio, exact 0.65"
        "${super}_SHIFT, C, layoutmsg, orientationleft"
        "${super}, H, layoutmsg, addmaster"
        "${super}, L, layoutmsg, removemaster"
        "${super}_SHIFT, H, splitratio, -0.05"
        "${super}_SHIFT, L, splitratio, +0.05"
        "${super}_ALT, L, exec, hyprlock"

        "${super}, 1, exec, hyprnome --previous"
        "${super}, 2, exec, hyprnome"
        "${super}_SHIFT, 1, exec, hyprnome --previous --move"
        "${super}_SHIFT, 2, exec, hyprnome --move"

        "${super}, mouse_down, workspace, e+1"
        "${super}, mouse_up, workspace, e-1"
      ];

      bindm = [
        "${super}, mouse:272, movewindow"
        "${super}, mouse:273, resizewindow"
      ];

      bindl = [
        ", XF86AudioMute, exec, swayosd-client --output-volume mute-toggle"
        ", XF86AudioRaiseVolume, exec, swayosd-client --output-volume raise"
        ", XF86AudioLowerVolume, exec, swayosd-client --output-volume lower"
        ", XF86AudioMicMute, exec, swayosd-client --input-volume mute-toggle"
        ", XF86MonBrightnessDown, exec, swayosd-client --brightness lower"
        ", XF86MonBrightnessUp, exec, swayosd-client --brightness raise"
        ", XF86Display, exec, ~/.config/${monitorScript}"
        ", XF86WLAN, exec, sleep 0.2 && ${vars.notifySend} \"WiFi\" \"$(nmcli radio wifi)\""
        ", XF86Messenger, togglespecialworkspace"
        ", XF86Favorites, exec, killall rofi || rofi -show drun"
      ];
    };

    extraConfig = # hyprlang
      ''
        bind = CTRL, Alt_L, submap, passthrough
        submap = passthrough
        bind = CTRL, Alt_L, submap, reset
        submap = reset
      '';
  };

  xdg.configFile = {
    ${gapsScript} = {
      executable = true;
      text = # fish
        ''
          #!/usr/bin/env fish

          hyprctl keyword general:gaps_out $(math 10 - $(hyprctl getoption general:gaps_out -j | jq -r ".custom" | choose 1))
          hyprctl keyword general:gaps_in $(math 5 - $(hyprctl getoption general:gaps_in -j | jq -r ".custom" | choose 1))
          hyprctl keyword general:border_size $(math 2 - $(hyprctl getoption general:border_size -j | jq -r ".int"))
          hyprctl keyword decoration:rounding $(math 8 - $(hyprctl getoption decoration:rounding -j | jq -r ".int"))
        '';
    };

    ${setBackgroundScript} = {
      executable = true;
      text = # fish
        ''
          #!/usr/bin/env fish

          if [ (hyprctl getoption animations:enabled -j | jq -r ".int") = "1" ]
            swww img \
              --transition-type $(random choice grow wave outer) \
              --transition-wave 80,40 \
              --transition-angle $(random choice 45 90 135 225 270 315) \
              --transition-pos $(random choice center top left right bottom top-left top-right bottom-left bottom-right) \
              --transition-step 200 \
              --transition-duration 1.5 \
              --transition-fps 240 \
              --outputs "$argv[1]" \
              "$argv[2]"
          else
            swww img \
              --transition-type simple \
              --transition-step 255 \
              --outputs "$argv[1]" \
              "$argv[2]"
          end
        '';
    };

    ${randomBackgroundScript} = {
      executable = true;
      text = # fish
        ''
          #!/usr/bin/env fish

          for monitor in (hyprctl monitors -j | jq -r '.[].name')
            ~/.config/${setBackgroundScript} "$monitor" "$(random choice $(fd . ${osu-backgrounds}/2024-07-15-Aerial-Antics-Art-Contest-All-Entries --follow -e jpg -e png))"
          end
        '';
    };

    ${swapBackgroundScript} = {
      executable = true;
      text = # fish
        ''
          #!/usr/bin/env fish

          set M "$(swww query | cut -d ':' -f 5)"
          set M1 "$(echo "$M" | head -n 1 | awk '{$1=$1};1')"
          set M2 "$(echo "$M" | tail -n 1 | awk '{$1=$1};1')"

          ~/.config/${setBackgroundScript} "$(swww query | choose 0 | choose -c 0..-1 | tail -n 1)" "$M1"
          ~/.config/${setBackgroundScript} "$(swww query | choose 0 | choose -c 0..-1 | head -n 1)" "$M2"
        '';
    };

    ${monitorScript} = {
      executable = true;
      text = # fish
        ''
          #!/usr/bin/env fish

          if test -n "$(hyprctl monitors -j | jq -r '.[] | select(.name | contains("eDP-1"))')"
            hyprctl keyword monitor eDP-1,disable
          else
            hyprctl keyword monitor eDP-1,preferred,auto-left,1
          end
        '';
    };
  };

  programs.hyprlock = {
    enable = true;

    settings = {
      general = {
        hide_cursor = true;
        grace = 2;
      };

      background = {
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
        outer_color = "rgba(25, 20, 20, 0)";
        inner_color = "rgba(25, 20, 20, 0)";
        font_color = "rgba(222, 222, 222, 1.0)";
        placeholder_text = "パスワード";
      };
    };
  };

  services.hypridle = {
    enable = true;

    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };

      listener = [
        {
          timeout = 150;
          on-timeout = "brightnessctl set 0 --save && brightnessctl --device=tpacpi::kbd_backlight set 0 --save";
          on-resume = "brightnessctl --restore && brightnessctl --device=tpacpi::kbd_backlight --restore";
        }
        {
          timeout = 300;
          on-timeout = "loginctl lock-session";
        }
        {
          timeout = 380;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
        {
          timeout = 1800;
          on-timeout = "systemctl suspend";
        }
      ];
    };
  };

  services = {
    batsignal.enable = true;
    hyprpaper.enable = mkForce false;
  };
}
