{ pkgs, config, lib, ... }:

let
  opacity = lib.strings.floatToString config.stylix.opacity.terminal;
  modifier = "SUPER";
in
{
  xdg.configFile."hypr/gaps.sh" = {
    executable = true;
    text = /* bash */ ''
      #/usr/bin/env bash
      hyprctl keyword general:gaps_out $((10 - $(hyprctl getoption general:gaps_out -j | jq -r ".int")))
      hyprctl keyword general:gaps_in $((5 - $(hyprctl getoption general:gaps_in -j | jq -r ".int")))
      hyprctl keyword general:border_size $((2 - $(hyprctl getoption general:border_size -j | jq -r ".int")))
      hyprctl keyword decoration:rounding $((8 - $(hyprctl getoption decoration:rounding -j | jq -r ".int")))
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
          "$argv"
      else
        swww img \
          --transition-type simple \
          --transition-step 255 \
          "$argv"
      end
    '';
  };

  xdg.configFile."hypr/random-bg.fish" = {
    executable = true;
    text = /* fish */ ''
      #!/usr/bin/env fish

      cd ~/.config/hypr
      ./set-bg.fish "$(random choice $(fd . /run/current-system/sw/share/backgrounds --follow -e jpg -e png))"
    '';
  };

  xdg.configFile."hypr/hyprland.conf".text = with config.lib.stylix.colors; /* bash */ ''
    env=XCURSOR_SIZE,24
    env=BROWSER,librewolf
    env=GTK_IM_MODULE,fcitx
    env=QT_IM_MODULE,fcitx
    env=XMODIFIERS,@im=fcitx
    env=SDL_IM_MODULE,fcitx
    env=GLFW_IM_MODULE,ibus
    env=SWWW_TRANSITION,grow
    env=SWWW_TRANSITION_STEP,200
    env=SWWW_TRANSITION_DURATION,1.5
    env=SWWW_TRANSITION_FPS,240
    env=SWWW_TRANSITION_WAVE,80,40
    env=WLR_NO_HARDWARE_CURSORS,1
    monitor=,preferred,auto,1
    monitor=HDMI-A-1,preferred,auto,1,mirror,eDP-1

    exec-once = sleep 0.1; swww init
    exec-once = wpctl set-volume @DEFAULT_AUDIO_SINK@ 20%
    exec-once = ironbar
    exec-once = fcitx5
    exec-once = hyprctl dispatch workspace 5000000
    exec-once = ${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1
    exec-once = hyprdim --no-dim-when-only --persist --ignore-leaving-special --dialog-dim
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
      gaps_in = 0
      gaps_out = -1
      border_size = 0
      col.active_border = rgba(${base03}ee) rgba(${base04}ee) 45deg
      col.inactive_border = rgba(${base02}99)
      layout = master
    }

    decoration {
      rounding = 0
      blur = yes
      blur_size = 4
      blur_passes = 2
      blur_new_optimizations = yes
      drop_shadow = yes
      shadow_range = 4
      shadow_render_power = 3
      col.shadow = rgba(1a1a1aee)
      fullscreen_opacity = 0.9999999
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
      mfact = 0.65
      special_scale_factor = 1
    }

    gestures {
      workspace_swipe = yes
    }

    device:synps/2-synaptics-touchpad {
      sensitivity = 0.75
      accel_profile = flat
      natural_scroll = yes
      disable_while_typing = no
    }

    device:tpps/2-elan-trackpoint {
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
    bind = $SUPER, Q, killactive
    bind = $SUPER, W, exec, ~/.config/hypr/random-bg.fish
    bind = $SUPER, P, exec, dunstify --icon=$(grimblast save screen) Screenshot Captured.
    bind = , Print, exec, grimblast copy area
    bind = $SUPER_ALT, delete, exit
    bind = $SUPER, T, exec, tessen
    bind = $SUPER, V, togglefloating
    bind = $SUPER, B, centerwindow
    bind = $SUPER, U, exec, ~/.config/hypr/gaps.sh
    bind = $SUPER, X, pin
    bind = $SUPER, F, fullscreen
    bind = $SUPER, S, exec, hyprctl dispatch swapactiveworkspaces 0 1
    bind = $SUPER_SHIFT, S, movetoworkspace, special
    bind = $SUPER, F1, exec, killall ..ironbar-wrapper || ironbar
    bind = $SUPER, F1, exec, eww close overlay || eww open overlay
    bind = $SUPER, F2, togglespecialworkspace

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

    bind = $SUPER, 1, exec, hyprland-relative-workspace b
    bind = $SUPER, 2, exec, hyprland-relative-workspace f
    bind = $SUPER, F11, exec, hyprland-relative-workspace b
    bind = $SUPER, F12, exec, hyprland-relative-workspace f
    bind = $SUPER_SHIFT, 1, exec, hyprland-relative-workspace b --with-window
    bind = $SUPER_SHIFT, 2, exec, hyprland-relative-workspace f --with-window

    bind = CTRL, Alt_L, submap, passthrough
    submap = passthrough
    bind = CTRL, Alt_L, submap, reset
    submap = reset

    layerrule = blur,ironbar
    layerrule = blur,notifications

    windowrulev2 = nomaxsize,class:^(winecfg\.exe)$
    windowrulev2 = nomaxsize,class:^(osu\.exe)$
    windowrulev2 = opaque,class:^(kitty)$
    windowrulev2 = noblur,class:^(kitty)$
    windowrulev2 = nodim,title:^(Picture-in-Picture)$
    windowrulev2 = tile,class:^(.qemu-system-x86_64-wrapped)$
    windowrulev2 = opacity ${opacity} ${opacity},class:^(thunar)$

    # Scroll through existing workspaces with super + scroll
    bind = $SUPER, mouse_down, workspace, e+1
    bind = $SUPER, mouse_up, workspace, e-1

    # Move/resize windows with super + LMB/RMB and dragging
    bindm = $SUPER, mouse:272, movewindow
    bindm = $SUPER, mouse:273, resizewindow

    # Change volume with keys
    # TODO: Change notification once at 0/100%
    bindl=, XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle && notify-send -t 2000 "Muted" "$(wpctl get-volume @DEFAULT_AUDIO_SINK@)"
    bindl=, XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+ && notify-send -t 2000 "Raised volume to" "$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | tail -c 3)%"
    bindl=, XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- && notify-send -t 2000 "Lowered volume to" "$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | tail -c 3)%"
    bindl=, XF86MonBrightnessDown, exec, brightnessctl set 5%- && notify-send -t 2000 "Decreased brightness to" "$(brightnessctl get)"
    bindl=, XF86MonBrightnessUp, exec, brightnessctl set +5% && notify-send -t 2000 "Increased brightness to" "$(brightnessctl get)"

    misc {
      disable_hyprland_logo = yes
      animate_manual_resizes = yes
      animate_mouse_windowdragging = yes
      disable_autoreload = yes
    }
  '';
}
