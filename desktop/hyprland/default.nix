{
  programs.hyprland.enable = true;

  home-manager.sharedModules = [{
    xdg.configFile."hypr/hyprland.conf".text = ''
      env=XCURSOR_SIZE,24
      env=BROWSER,librewolf
      env=GTK_IM_MODULE,fcitx
      env=QT_IM_MODULE,fcitx
      env=XMODIFIERS,@im=fcitx
      env=SDL_IM_MODULE,fcitx
      env=GLFW_IM_MODULE,ibus
      monitor=,preferred,auto,1

      exec-once = swaybg --mode fill --image "$(fd -d 1 wallpaper.png /nix/store/)"
      exec-once = wpctl set-volume @DEFAULT_AUDIO_SINK@ 20%
      exec-once = sleep 0.5 && waybar
      exec-once = fcitx5                          # Japanese input support
      exec-once = mullvad-vpn
      exec-once = wl-paste -p --watch wl-copy -pc # Disable middle click paste

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
      }

      general {
        gaps_in = 0
        gaps_out = 0
        border_size = 0
        col.active_border = rgba(f4bf75ee) rgba(fd971fee) 45deg
        col.inactive_border = rgba(49483eaa)
        layout = master
      }

      decoration {
        rounding = 0
        blur = yes
        blur_size = 3
        blur_passes = 1
        blur_new_optimizations = yes
        drop_shadow = yes
        shadow_range = 4
        shadow_render_power = 3
        col.shadow = rgba(1a1a1aee)
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
        no_gaps_when_only = yes
        special_scale_factor = 0.95
      }

      master {
        new_is_master = yes
        new_on_top = yes
        mfact = 0.65
        special_scale_factor = 0.95
        no_gaps_when_only = yes
        allow_small_split = yes
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
        workspace_back_and_forth = yes
        allow_workspace_cycles = yes
      }

      bind = SUPER_SHIFT, Return, exec, kitty
      bind = SUPER, Q, killactive,
      bind = SUPER, P, exec, grim -g "$(slurp)"
      bind = , Print, exec, grim && dunstify Screenshot Captured.
      bind = SUPER_ALT, delete, exit
      bind = SUPER, V, togglefloating,
      bind = SUPER, V, centerwindow,
      bind = SUPER, O, exec, killall .waybar-wrapped || waybar
      bind = SUPER, X, pin
      bind = SUPER, F, fullscreen, 1
      bind = SUPER_SHIFT, F, fullscreen
      bind = SUPER, bracketright, changegroupactive, f
      bind = SUPER, bracketleft, changegroupactive, b
      bind = SUPER, S, togglespecialworkspace
      bind = SUPER_SHIFT, S, movetoworkspace, special
      bind = SUPER_SHIFT, S, togglespecialworkspace
      bind = SUPER, F1, exec, killall rofi || rofi -show drun

      bind = SUPER, Return, exec, ~/.config/hypr/swapmaster.sh
      bind = SUPER, J, layoutmsg, cyclenext
      bind = SUPER, K, layoutmsg, cycleprev
      bind = SUPER_SHIFT, J, layoutmsg, swapnext
      bind = SUPER_SHIFT, K, layoutmsg, swapprev
      bind = SUPER, C, layoutmsg, orientationnext
      bind = SUPER_SHIFT, C, layoutmsg, orientationprev
      bind = SUPER, H, layoutmsg, addmaster
      bind = SUPER, L, layoutmsg, removemaster
      bind = SUPER_SHIFT, H, splitratio, -0.05
      bind = SUPER_SHIFT, L, splitratio, +0.05

      bind = SUPER, grave, workspace, previous
      bind = SUPER, 1, workspace, 1
      bind = SUPER, 2, workspace, 2
      bind = SUPER, 3, workspace, 3
      bind = SUPER, 4, workspace, 4
      bind = SUPER, 5, workspace, 5
      bind = SUPER, 6, workspace, 6
      bind = SUPER, 7, workspace, 7
      bind = SUPER, 8, workspace, 8
      bind = SUPER, 9, workspace, 9
      bind = SUPER, 0, workspace, 10
      bind = SUPER_SHIFT, 1, movetoworkspace, 1
      bind = SUPER_SHIFT, 2, movetoworkspace, 2
      bind = SUPER_SHIFT, 3, movetoworkspace, 3
      bind = SUPER_SHIFT, 4, movetoworkspace, 4
      bind = SUPER_SHIFT, 5, movetoworkspace, 5
      bind = SUPER_SHIFT, 6, movetoworkspace, 6
      bind = SUPER_SHIFT, 7, movetoworkspace, 7
      bind = SUPER_SHIFT, 8, movetoworkspace, 8
      bind = SUPER_SHIFT, 9, movetoworkspace, 9
      bind = SUPER_SHIFT, 0, movetoworkspace, 10
      bind = SUPER_CTRL, 1, exec, ~/.config/hypr/tags.sh 1
      bind = SUPER_CTRL, 2, exec, ~/.config/hypr/tags.sh 2
      bind = SUPER_CTRL, 3, exec, ~/.config/hypr/tags.sh 3
      bind = SUPER_CTRL, 4, exec, ~/.config/hypr/tags.sh 4
      bind = SUPER_CTRL, 5, exec, ~/.config/hypr/tags.sh 5
      bind = SUPER_CTRL, 6, exec, ~/.config/hypr/tags.sh 6
      bind = SUPER_CTRL, 7, exec, ~/.config/hypr/tags.sh 7
      bind = SUPER_CTRL, 8, exec, ~/.config/hypr/tags.sh 8
      bind = SUPER_CTRL, 9, exec, ~/.config/hypr/tags.sh 9
      bind = SUPER_CTRL, 0, exec, ~/.config/hypr/tags.sh 10

      layerrule = blur,waybar
      layerrule = blur,rofi

      # Scroll through existing workspaces with super + scroll
      bind = SUPER, mouse_down, workspace, e+1
      bind = SUPER, mouse_up, workspace, e-1

      # Move/resize windows with super + LMB/RMB and dragging
      bindm = SUPER, mouse:272, movewindow
      bindm = SUPER, mouse:273, resizewindow

      # Change volume with keys
      # TODO: Change notification once at 0/100%
      bindl=, XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle && notify-send -t 2000 "Muted" "$(wpctl get-volume @DEFAULT_AUDIO_SINK@)"
      bindl=, XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+ && notify-send -t 2000 "Raised volume to" "$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | tail -c 3)%"
      bindl=, XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- && notify-send -t 2000 "Lowered volume to" "$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | tail -c 3)%"
      bindl=, XF86MonBrightnessDown, exec, brightnessctl set 5%- && notify-send -t 2000 "Decreased brightness to" "$(brightnessctl get)"
      bindl=, XF86MonBrightnessUp, exec, brightnessctl set +5% && notify-send -t 2000 "Increased brightness to" "$(brightnessctl get)"

      misc {
        disable_hyprland_logo = yes
        animate_mouse_windowdragging = yes
        focus_on_activate = yes
      }
    '';
    xdg.configFile."hypr/swapmaster.sh".source = ./swapmaster.sh;
    xdg.configFile."hypr/tags.sh".source = ./tags.sh;
  }];
}
