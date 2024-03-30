{ pkgs, config, lib, ... }:

let
  opacity = lib.strings.floatToString config.stylix.opacity.terminal;
  modifier = "SUPER";
in
{
  home.packages = with pkgs; [
    hyprnome
    hypridle
    hyprlock
  ];

  wayland.windowManager.hyprland = {
    enable = true;

    plugins = [
      (pkgs.callPackage ../packages/hycov.nix { })
    ];
  };

  xdg.configFile."hypr/gaps.sh" = {
    executable = true;
    text = /* bash */ ''
      #!/usr/bin/env bash
      hyprctl keyword general:gaps_out $((10 - $(hyprctl getoption general:gaps_out -j | jq -r ".custom" | choose 1)))
      hyprctl keyword general:gaps_in $((5 - $(hyprctl getoption general:gaps_in -j | jq -r ".custom" | choose 1)))
      hyprctl keyword general:border_size $((4 - $(hyprctl getoption general:border_size -j | jq -r ".int")))
      hyprctl keyword decoration:rounding $((8 - $(hyprctl getoption decoration:rounding -j | jq -r ".int")))
    '';
  };

  xdg.configFile."hypr/raise-volume.fish" = {
    executable = true;
    text = /* fish */ ''
      #!/usr/bin/env fish

      wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+

      set VOL $(math "$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | choose 1) * 100")

      notify-send -t 2000 "Raised volume to" "$VOL%"
    '';
  };

  xdg.configFile."hypr/lower-volume.fish" = {
    executable = true;
    text = /* fish */ ''
      #!/usr/bin/env fish

      wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-

      set VOL $(math "$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | choose 1) * 100")

      notify-send -t 2000 "Lowered volume to" "$VOL%"
    '';
  };

  xdg.configFile."hypr/set-bg.fish" = {
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

  xdg.configFile."hypr/random-bg.fish" = {
    executable = true;
    text = /* fish */ ''
      #!/usr/bin/env fish

      cd ~/.config/hypr

      for monitor in (hyprctl monitors -j | jq -r '.[].name')
        ./set-bg.fish "$monitor" "$(random choice $(fd . /run/current-system/sw/share/backgrounds/Spring2024FanartSubmissions --follow -e jpg -e png))"
      end
    '';
  };

  xdg.configFile."hypr/swap-bg.fish" = {
    executable = true;
    text = /* fish */ ''
      #!/usr/bin/env fish

      set M "$(swww query | choose -1)"
      set M1 "$(echo "$M" | head -n 1)"
      set M2 "$(echo "$M" | tail -n 1)"

      cd ~/.config/hypr

      ./set-bg.fish "$(swww query | choose 0 | choose -c 0..-1 | tail -n 1)" $M1
      ./set-bg.fish "$(swww query | choose 0 | choose -c 0..-1 | head -n 1)" $M2
    '';
  };

  xdg.configFile."hypr/hyprlock.conf".text = /* bash */ ''
    general {
      hide_cursor = true
      grace = 2
    }

    background {
      color = rgba(25, 20, 20, 1.0)
      path = screenshot
      blur_passes = 2
      brightness = 0.5
    }

    label {
      text = パスワードをご入力ください
      color = rgba(222, 222, 222, 1.0)
      font_size = 50
      font_family = Noto Sans CJK JP
      position = 0, 70
      halign = center
      valign = center
    }

    input-field {
      size = 50, 50
      dots_size = 0.33
      dots_spacing = 0.15
      outer_color = rgba(25, 20, 20, 0)
      inner_color = rgba(25, 20, 20, 0)
      font_color = rgba(222, 222, 222, 1.0)
      placeholder_text = パスワード
    }
  '';

  xdg.configFile."hypr/hypridle.conf".text = /* bash */ ''
    general {
      lock_cmd = pidof hyprlock || hyprlock
      before_sleep_cmd = loginctl lock-session
      after_sleep_cmd = hyprctl dispatch dpms on
    }

    listener {
      timeout = 150
      on-timeout = brightnessctl -s set 10
      on-resume = brightnessctl -r
    }

    listener {
      timeout = 300
      on-timeout = loginctl lock-session
    }

    listener {
      timeout = 380
      on-timeout = hyprctl dispatch dpms off
      on-resume = hyprctl dispatch dpms on
    }

    listener {
      timeout = 1800
      on-timeout = systemctl suspend
    }
  '';

  xdg.configFile."hypr/hyprland.conf".text = with config.lib.stylix.colors; /* bash */ ''
    env=XCURSOR_SIZE,24
    env=BROWSER,librewolf
    env=QT_IM_MODULE,fcitx
    env=XMODIFIERS,@im=fcitx
    env=SDL_IM_MODULE,fcitx
    env=GLFW_IM_MODULE,ibus
    env=SWWW_TRANSITION,grow
    env=SWWW_TRANSITION_STEP,200
    env=SWWW_TRANSITION_DURATION,1.5
    env=SWWW_TRANSITION_FPS,240
    env=SWWW_TRANSITION_WAVE,80,40
    env=QT_AUTO_SCREEN_SCALE_FACTOR,1
    env=QT_QPA_PLATFORM,wayland;xcb
    env=QT_WAYLAND_DISABLE_WINDOWDECORATION,1
    env=QT_QPA_PLATFORMTHEME,qt5ct
    env=QT_STYLE_OVERRIDE,kvantum
    monitor=,preferred,auto,1

    exec-once = sleep 0.1; swww init
    exec-once = wpctl set-volume @DEFAULT_AUDIO_SINK@ 20%
    exec-once = ironbar
    exec-once = fcitx5
    exec-once = hyprctl dispatch workspace 5000000
    exec-once = ${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1
    exec-once = hyprdim --no-dim-when-only --persist --ignore-leaving-special --dialog-dim
    exec-once = hypridle
    exec-once = sleep 1 && eww open desktop-icons
    exec-once = ~/.config/hypr/random-bg.fish

    input {
      kb_layout = us
      accel_profile = flat
      follow_mouse = 1
      mouse_refocus = 0
      sensitivity = 0
      touchpad {
        natural_scroll = yes
        disable_while_typing = no
      }
      repeat_rate = 50
      repeat_delay = 300
    }

    general {
      gaps_in = 5
      gaps_out = 10
      border_size = 4
      col.active_border = rgb(${base04}) rgb(${base05}) 45deg
      col.inactive_border = rgb(${base02})
      layout = master
    }

    decoration {
      rounding = 8
      drop_shadow = yes
      shadow_range = 4
      shadow_render_power = 3
      col.shadow = rgba(1a1a1aee)

      blur {
        enabled = yes
        size = 4
        passes = 2
      }
    }

    animations {
      enabled = yes
      bezier = myBezier, 0.05, 0.9, 0.1, 1.05
      animation = windows, 1, 7, myBezier
      animation = windowsOut, 1, 7, default, popin 80%
      animation = border, 1, 10, default
      animation = borderangle, 1, 8, default
      animation = fade, 1, 7, default
      animation = workspaces, 1, 6, default, slidevert
      animation = specialWorkspace, 1, 6, default, fade
    }

    dwindle {
      preserve_split = yes
      special_scale_factor = 1
    }

    master {
      new_is_master = no
      new_on_top = no
      no_gaps_when_only = yes
      mfact = 0.65
      special_scale_factor = 1
    }

    gestures {
      workspace_swipe = yes
    }

    device {
      name = synps/2-synaptics-touchpad
      sensitivity = 0.75
      accel_profile = flat
      natural_scroll = yes
      disable_while_typing = no
    }

    device {
      name = tpps/2-elan-trackpoint
      sensitivity = 0.5
      accel_profile = flat
    }

    binds {
      allow_workspace_cycles = yes
    }

    $SUPER = ${modifier}
    $SUPER_SHIFT = ${modifier}_SHIFT
    $SUPER_ALT = ${modifier}_ALT

    bind = $SUPER_SHIFT, Return, exec, kitty
    bind = $SUPER_SHIFT, Q, killactive
    bind = $SUPER, W, exec, ~/.config/hypr/random-bg.fish
    bind = $SUPER_SHIFT, W, exec, ~/.config/hypr/swap-bg.fish
    bind = $SUPER, P, exec, dunstify --icon=$(grimblast save screen) Screenshot Captured.
    bind = , Print, exec, grimblast --freeze copy area
    bind = $SUPER_ALT, delete, exit
    bind = $SUPER, T, exec, tessen
    bind = $SUPER, V, togglefloating
    bind = $SUPER, B, centerwindow
    bind = $SUPER, U, exec, ~/.config/hypr/gaps.sh
    bind = $SUPER, X, pin
    bind = $SUPER, F, fullscreen
    bind = $SUPER, S, swapactiveworkspaces, 0 1
    bind = $SUPER_SHIFT, S, movetoworkspace, special
    bind = $SUPER, O, exec, killall .ironbar-wrapper || ironbar
    bind = $SUPER_SHIFT, O, exec, eww close overlay || eww open overlay
    bind = $SUPER, F1, exec, killall rofi || rofi -show drun
    bind = $SUPER, F2, togglespecialworkspace
    bind = $SUPER, comma, exec, playerctl -p mpv position "5-" && notify-send -t 2000 "Minus 5 seconds" "$(playerctl -p mpv position)"
    bind = $SUPER, period, exec, playerctl -p mpv position "5+" && notify-send -t 2000 "Plus 5 seconds" "$(playerctl -p mpv position)"
    bind = $SUPER_SHIFT, comma, exec, playerctl -p mpv previous && notify-send -t 2000 "Previous track" "$(playerctl -p mpv metadata xesam:title)"
    bind = $SUPER_SHIFT, period, exec, playerctl -p mpv next && notify-send -t 2000 "Next track" "$(playerctl -p mpv metadata xesam:title)"
    bind = $SUPER, slash, exec, playerctl -p mpv play-pause && notify-send -t 2000 "mpv" "$(playerctl -p mpv status)"
    bind = $SUPER, M, focusmonitor, +1
    bind = $SUPER_SHIFT, M, focusmonitor, -1

    bind = $SUPER, Return, layoutmsg, swapwithmaster master
    bind = $SUPER, J, layoutmsg, cyclenext
    bind = $SUPER, K, layoutmsg, cycleprev
    bind = $SUPER_SHIFT, J, layoutmsg, swapnext
    bind = $SUPER_SHIFT, K, layoutmsg, swapprev
    bind = $SUPER, C, splitratio, exact 0.80
    bind = $SUPER, C, layoutmsg, orientationtop
    bind = $SUPER_SHIFT, C, splitratio, exact 0.65
    bind = $SUPER_SHIFT, C, layoutmsg, orientationleft
    bind = $SUPER, H, layoutmsg, addmaster
    bind = $SUPER, L, layoutmsg, removemaster
    bind = $SUPER_SHIFT, H, splitratio, -0.05
    bind = $SUPER_SHIFT, L, splitratio, +0.05
    bind = $SUPER_ALT, L, exec, hyprlock

    bind = $SUPER, 1, exec, hyprnome --previous
    bind = $SUPER, 2, exec, hyprnome
    bind = $SUPER, F11, exec, hyprnome --previous
    bind = $SUPER, F12, exec, hyprnome
    bind = $SUPER_SHIFT, 1, exec, hyprnome --previous --move
    bind = $SUPER_SHIFT, 2, exec, hyprnome --move

    bind = $SUPER, Tab, hycov:toggleoverview
    bind = $SUPER, H, hycov:movefocus,l
    bind = $SUPER, L, hycov:movefocus,r
    bind = $SUPER, K, hycov:movefocus,u
    bind = $SUPER, J, hycov:movefocus,d

    plugin {
      hycov {
        hotarea_size = 0
        enable_gesture = 1
      }
    }

    bind = CTRL, Alt_L, submap, passthrough
    submap = passthrough
    bind = CTRL, Alt_L, submap, reset
    submap = reset

    layerrule = blur,ironbar
    layerrule = blur,rofi
    layerrule = blur,notifications

    windowrulev2 = nomaxsize,class:^(winecfg\.exe)$
    windowrulev2 = nomaxsize,class:^(osu\.exe)$
    windowrulev2 = opaque,class:^(kitty)$
    windowrulev2 = noblur,class:^(kitty)$
    windowrulev2 = nodim,title:^(Picture-in-Picture)$
    windowrulev2 = nodim,title:^(ピクチャーインピクチャー)$
    windowrulev2 = nodim,class:^(mpv)$
    windowrulev2 = tile,class:^(.qemu-system-x86_64-wrapped)$
    windowrulev2 = opacity ${opacity} ${opacity},class:^(thunar)$
    windowrulev2 = float,class:^(librewolf)$
    windowrulev2 = center 1,class:^(librewolf)$

    # Scroll through existing workspaces with super + scroll
    bind = $SUPER, mouse_down, workspace, e+1
    bind = $SUPER, mouse_up, workspace, e-1

    # Move/resize windows with super + LMB/RMB and dragging
    bindm = $SUPER, mouse:272, movewindow
    bindm = $SUPER, mouse:273, resizewindow

    # Change volume with keys
    bindl=, XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle && notify-send -t 2000 "Muted" "$(wpctl get-volume @DEFAULT_AUDIO_SINK@)"
    bindl=, XF86AudioRaiseVolume, exec, ~/.config/hypr/raise-volume.fish
    bindl=, XF86AudioLowerVolume, exec, ~/.config/hypr/lower-volume.fish
    bindl=, XF86MonBrightnessDown, exec, brightnessctl set 5%- && notify-send -t 2000 "Decreased brightness to" "$(brightnessctl get)"
    bindl=, XF86MonBrightnessUp, exec, brightnessctl set +5% && notify-send -t 2000 "Increased brightness to" "$(brightnessctl get)"

    misc {
      disable_hyprland_logo = yes
      animate_manual_resizes = yes
      animate_mouse_windowdragging = yes
      disable_autoreload = yes
      new_window_takes_over_fullscreen = 1
    }
  '';
}
