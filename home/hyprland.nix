{
  nixosConfig,
  pkgs,
  lib,
  ...
}:

let
  inherit (nixosConfig._module.specialArgs) nix-config;

  inherit (lib) mkForce;

  inherit (nix-config.packages.${pkgs.system})
    osu-backgrounds
    dunst-scripts
    ;

  opacity = "0.95";
  super = "SUPER";

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
    swww
    grimblast
    brightnessctl
    mpvpaper
    lnch
    wev
    wf-recorder
    playerctl
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
        "ironbar"
        "fcitx5"
        "hyprctl dispatch workspace 5000000"
        "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"
        "hyprdim"
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

        shadow = {
          range = 30;
          render_power = 3;
        };

        blur = {
          enabled = true;
          size = 5;
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
        new_on_top = true;
        new_status = "master";
        mfact = 0.55;
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
        "nodim,title:^(Picture-in-Picture|ピクチャーインピクチャー)$"
        "nodim,class:^(mpv)$"
        "tile,class:^(.qemu-system-x86_64-wrapped)$"
        "opacity ${opacity} ${opacity},class:^(thunar)$"
        "float,class:^(librewolf|Mullvad Browser)$"
        "center 1,class:^(librewolf|Mullvad Browser)$"
      ];

      misc = {
        disable_hyprland_logo = true;
        disable_hyprland_qtutils_check = true;
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
        "${super}, P, exec, grimblast --notify save screen"
        ", Print, exec, grimblast --freeze copy area"
        "${super}, bracketleft, exec, killall rofi || rofi -show"
        "${super}, bracketright, exec, kitty yazi"
        "${super}_ALT, delete, exit"
        "${super}, V, togglefloating"
        "${super}, U, exec, ~/.config/${gapsScript}"
        "${super}, X, pin"
        "${super}, F, fullscreen"
        "${super}, Tab, exec, hyprctl dispatch overview:toggle"
        "${super}, S, swapactiveworkspaces, 0 1"
        "${super}_SHIFT, S, movetoworkspace, special"
        "${super}, O, exec, killall .ironbar-wrapper inotifywait pactl || ironbar"
        "${super}, M, focusmonitor, +1"
        "${super}_SHIFT, M, focusmonitor, -1"

        "${super}, Return, layoutmsg, swapwithmaster master"
        "${super}, J, layoutmsg, cyclenext"
        "${super}, K, layoutmsg, cycleprev"
        "${super}_SHIFT, J, layoutmsg, swapnext"
        "${super}_SHIFT, K, layoutmsg, swapprev"
        "${super}, C, splitratio, exact 0.80"
        "${super}, C, layoutmsg, orientationtop"
        "${super}_SHIFT, C, splitratio, exact 0.55"
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
        ", XF86AudioMute, exec, ${dunst-scripts}/bin/mv-mute"
        ", XF86AudioMicMute, exec, ${dunst-scripts}/bin/mv-mic"
        ", XF86MonBrightnessDown, exec, ${dunst-scripts}/bin/mb-down"
        ", XF86MonBrightnessUp, exec, ${dunst-scripts}/bin/mb-up"
        ", XF86Display, exec, ~/.config/${monitorScript}"
        ", XF86AudioPrev, exec, playerctl -p playerctld previous"
        ", XF86AudioNext, exec, playerctl -p playerctld next"
        ", XF86AudioPlay, exec, playerctl -p playerctld play"
        ", XF86AudioPause, exec, playerctl -p playerctld pause"
        ", XF86Messenger, togglespecialworkspace"
      ];

      binde = [
        ", XF86AudioRaiseVolume, exec, ${dunst-scripts}/bin/mv-up"
        ", XF86AudioLowerVolume, exec, ${dunst-scripts}/bin/mv-down"
        ", XF86AudioForward, exec, playerctl -p playerctld position 10+"
        ", XF86AudioRewind, exec, playerctl -p playerctld position 10-"
      ];
    };

    extraConfig = # hyprlang
      ''
        bind = ${super}_ALT, BackSpace, submap, passthrough
        submap = passthrough
        bind = ${super}_ALT, BackSpace, submap, reset
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
            ~/.config/${setBackgroundScript} "$monitor" "$(random choice $(fd . ${osu-backgrounds}/2025-01-01-Midnight-Moment-Art-Contest-All-Entries --follow -e jpg -e png))"
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

  services = {
    hyprpaper.enable = mkForce false;
  };
}
