{ pkgs, ... }:

let
  inherit (pkgs) polkit_gnome callPackage;

  opacity = "0.95";
  super = "SUPER";

  osu-backgrounds = callPackage ../packages/osu-backgrounds.nix { };

  raiseVolumeScript = "hypr/raise-volume.fish";
  lowerVolumeScript = "hypr/lower-volume.fish";
  gapsScript = "hypr/gaps.sh";
  randomBackgroundScript = "hypr/random-bg.fish";
  swapBackgroundScript = "hypr/swap-bg.fish";
  setBackgroundScript = "hypr/set-bg.fish";
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
    mpvpaper
    lnch
    wev
    tessen
    wtype
    dmenu-wayland
    thud
    python311Packages.icoextract
    wallust
    activate-linux
    wl-clipboard-rs
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

      monitor = ",preferred,auto,1";

      exec-once = [
        "sleep 0.1; swww-daemon"
        "wpctl set-volume @DEFAULT_AUDIO_SINK@ 20%"
        "ironbar"
        "fcitx5"
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
        new_is_master = false;
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
        "nomaxsize,class:^(winecfg\.exe)$"
        "nomaxsize,class:^(osu\.exe)$"
        "opaque,class:^(kitty)$"
        "noblur,class:^(kitty)$"
        "nodim,title:^(Picture-in-Picture)$"
        "nodim,title:^(ピクチャーインピクチャー)$"
        "nodim,class:^(mpv)$"
        "tile,class:^(.qemu-system-x86_64-wrapped)$"
        "opacity ${opacity} ${opacity},class:^(thunar)$"
        "float,class:^(librewolf)$"
        "center 1,class:^(librewolf)$"
      ];

      misc = {
        disable_hyprland_logo = true;
        animate_manual_resizes = true;
        disable_autoreload = true;
        new_window_takes_over_fullscreen = 1;
        initial_workspace_tracking = 0;
      };

      bind = [
        "${super}_SHIFT, Return, exec, kitty"
        "${super}_SHIFT, Q, killactive"
        "${super}, W, exec, ~/.config/${randomBackgroundScript}"
        "${super}_SHIFT, W, exec, ~/.config/${swapBackgroundScript}"
        "${super}, P, exec, dunstify --icon=$(grimblast save screen) Screenshot Captured."
        ", Print, exec, grimblast --freeze copy area"
        "${super}_ALT, delete, exit"
        "${super}, T, exec, tessen"
        "${super}, V, togglefloating"
        "${super}, B, centerwindow"
        "${super}, U, exec, ~/.config/${gapsScript}"
        "${super}, X, pin"
        "${super}, F, fullscreen"
        "${super}, S, swapactiveworkspaces, 0 1"
        "${super}_SHIFT, S, movetoworkspace, special"
        "${super}_SHIFT, A, exec, killall activate-linux || activate-linux -s 1.15 -x 412 -y 120 -c 1-1-1-0.05"
        "${super}, O, exec, killall .ironbar-wrapper inotifywait pactl || ironbar"
        "${super}_SHIFT, O, exec, eww close overlay || eww open overlay"
        "${super}, F1, exec, killall rofi || rofi -show drun"
        "${super}, F2, togglespecialworkspace"
        "${super}, comma, exec, playerctl -p mpv position \"5-\" && notify-send -t 2000 \"Minus 5 seconds\" \"$(playerctl -p mpv position)\""
        "${super}, period, exec, playerctl -p mpv position \"5+\" && notify-send -t 2000 \"Plus 5 seconds\" \"$(playerctl -p mpv position)\""
        "${super}_SHIFT, comma, exec, playerctl -p mpv previous && notify-send -t 2000 \"Previous track\" \"$(playerctl -p mpv metadata xesam:title)\""
        "${super}_SHIFT, period, exec, playerctl -p mpv next && notify-send -t 2000 \"Next track\" \"$(playerctl -p mpv metadata xesam:title)\""
        "${super}, slash, exec, playerctl -p mpv play-pause && notify-send -t 2000 \"mpv\" \"$(playerctl -p mpv status)\""
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
        "${super}, F11, exec, hyprnome --previous"
        "${super}, F12, exec, hyprnome"
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
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle && notify-send -t 2000 \"Muted\" \"$(wpctl get-volume @DEFAULT_AUDIO_SINK@)\""
        ", XF86AudioRaiseVolume, exec, ~/.config/${raiseVolumeScript}"
        ", XF86AudioLowerVolume, exec, ~/.config/${lowerVolumeScript}"
        ", XF86MonBrightnessDown, exec, brightnessctl set 5%- && notify-send -t 2000 \"Decreased brightness to\" \"$(brightnessctl get)\""
        ", XF86MonBrightnessUp, exec, brightnessctl set +5% && notify-send -t 2000 \"Increased brightness to\" \"$(brightnessctl get)\""
      ];
    };

    extraConfig = /* bash */ ''
      bind = CTRL, Alt_L, submap, passthrough
      submap = passthrough
      bind = CTRL, Alt_L, submap, reset
      submap = reset
    '';
  };

  xdg.configFile.${gapsScript} = {
    executable = true;
    text = /* bash */ ''
      #!/usr/bin/env bash
      hyprctl keyword general:gaps_out $((10 - $(hyprctl getoption general:gaps_out -j | jq -r ".custom" | choose 1)))
      hyprctl keyword general:gaps_in $((5 - $(hyprctl getoption general:gaps_in -j | jq -r ".custom" | choose 1)))
      hyprctl keyword general:border_size $((2 - $(hyprctl getoption general:border_size -j | jq -r ".int")))
      hyprctl keyword decoration:rounding $((8 - $(hyprctl getoption decoration:rounding -j | jq -r ".int")))
    '';
  };

  xdg.configFile.${raiseVolumeScript} = {
    executable = true;
    text = /* fish */ ''
      #!/usr/bin/env fish

      wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+

      set VOL $(math "$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | choose 1) * 100")

      notify-send -t 2000 "Raised volume to" "$VOL%"
    '';
  };

  xdg.configFile.${lowerVolumeScript} = {
    executable = true;
    text = /* fish */ ''
      #!/usr/bin/env fish

      wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-

      set VOL $(math "$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | choose 1) * 100")

      notify-send -t 2000 "Lowered volume to" "$VOL%"
    '';
  };

  xdg.configFile.${setBackgroundScript} = {
    executable = true;
    text = /* fish */ ''
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

  xdg.configFile.${randomBackgroundScript} = {
    executable = true;
    text = /* fish */ ''
      #!/usr/bin/env fish

      for monitor in (hyprctl monitors -j | jq -r '.[].name')
        ~/.config/${setBackgroundScript} "$monitor" "$(random choice $(fd . ${osu-backgrounds}/2024-03-30-Spring-2024-Fanart-Contest-All-Entries --follow -e jpg -e png))"
      end
    '';
  };

  xdg.configFile.${swapBackgroundScript} = {
    executable = true;
    text = /* fish */ ''
      #!/usr/bin/env fish

      set M "$(swww query | cut -d ':' -f 5)"
      set M1 "$(echo "$M" | head -n 1 | awk '{$1=$1};1')"
      set M2 "$(echo "$M" | tail -n 1 | awk '{$1=$1};1')"

      ~/.config/${setBackgroundScript} "$(swww query | choose 0 | choose -c 0..-1 | tail -n 1)" "$M1"
      ~/.config/${setBackgroundScript} "$(swww query | choose 0 | choose -c 0..-1 | head -n 1)" "$M2"
    '';
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
          on-timeout = "brightnessctl -s set 10";
          on-resume = "brightnessctl -r";
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
}
