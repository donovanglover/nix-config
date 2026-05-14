{ nixosConfig, pkgs, ... }:

let
  inherit (nixosConfig._module.specialArgs) nix-config;

  inherit (nix-config.packages.${pkgs.stdenv.hostPlatform.system})
    osu-backgrounds
    ;

  randomBackgroundScript = "niri/random-bg.fish";
  setBackgroundScript = "niri/set-bg.fish";
in
{
  xdg.configFile = {
    "niri/config.kdl".text = # kdl
      ''
        input {
          keyboard {
            xkb {
              layout "us"
            }

            repeat-rate 50
            repeat-delay 300
          }

          touchpad {
            tap
            natural-scroll
          }

          mouse {
            accel-profile "flat"
          }
        }

        output "eDP-1" {
          scale 1
        }

        cursor {
          hide-after-inactive-ms 1000
        }

        layout {
          gaps 0

          focus-ring {
            off
          }

          empty-workspace-above-first

          shadow {
            on
          }

          preset-column-widths {
            proportion 0.34
            proportion 0.5
            proportion 0.66
          }
        }

        spawn-at-startup "ironbar"
        spawn-at-startup "awww-daemon"
        spawn-at-startup "~/.config/${randomBackgroundScript}"

        hotkey-overlay {
          skip-at-startup
        }

        prefer-no-csd

        screenshot-path "~/%Y-%m-%d %H-%M-%S.png"

        environment {
          BROWSER "librewolf"
          QT_IM_MODULE "fcitx"
          XMODIFIERS "@im=fcitx"
          SDL_IM_MODULE "fcitx"
          GLFW_IM_MODULE "ibus"
          AWWW_TRANSITION "grow"
          AWWW_TRANSITION_STEP "200"
          AWWW_TRANSITION_DURATION "1.5"
          AWWW_TRANSITION_FPS "240"
          AWWW_TRANSITION_WAVE "80,40"
          QT_QPA_PLATFORMTHEME "qt5ct"
          QT_STYLE_OVERRIDE "kvantum"
        }

        window-rule {
          match title=r#"Firefox$"#
          default-window-height { fixed 985; }
          default-column-width { fixed 1600; }
          min-height 985
          max-height 985
          min-width 1600
          max-width 1600
          open-floating false
        }

        window-rule {
          match app-id=r#"^mpv$"#
          default-floating-position x=0 y=0 relative-to="bottom-right";
          default-column-width { proportion 0.5; }
          default-window-height { proportion 0.28125; }
          min-width 960
          max-width 960
          min-height 540
          max-height 540
          open-floating true
        }

        window-rule {
          match app-id="^dropdown$"
          open-floating true
          default-floating-position x=0 y=0 relative-to="top"
          default-window-height { proportion 0.5; }
          default-column-width { proportion 0.8; }
        }

        window-rule {
          match app-id=r#"^Mullvad Browser$"#
          default-window-height { fixed 986; }
          default-column-width { fixed 1400; }
          min-height 986
          max-height 986
          min-width 1400
          max-width 1400
          open-floating false
        }

        window-rule {
          match app-id=r#"^osu!\.exe$"#
          exclude title="^osu!$"
          open-floating true
          open-focused true
        }

        binds {
          Mod+Shift+Return { spawn "kitty"; }
          Mod+BracketLeft { spawn-sh "killall rofi || rofi -show drun"; }

          Mod+O { spawn-sh "killall .ironbar-wrapper inotifywait pactl || ironbar"; }
          Mod+Shift+O repeat=false { toggle-overview; }
          Mod+T { spawn-sh "killall -s 34 wvkbd-deskintl || wvkbd-deskintl"; }

          Scroll_Lock { spawn-sh "wl-kbptr -o modes=floating,click -o mode_floating.source=detect -o mode_floating.label_font_family='Maple Mono' -o mode_floating.label_font_size='16 50% 100'"; }
          Pause { spawn-sh "wl-kbptr -o modes=floating,click -o mode_floating.source=detect -o mode_floating.label_font_family='Maple Mono' -o mode_floating.label_font_size='16 50% 100' -o mode_click.button=right"; }

          XF86AudioRaiseVolume allow-when-locked=true { spawn-sh "mv-up"; }
          XF86AudioLowerVolume allow-when-locked=true { spawn-sh "mv-down"; }
          XF86MonBrightnessUp allow-when-locked=true { spawn "mb-up"; }
          XF86MonBrightnessDown allow-when-locked=true { spawn "mb-down"; }

          XF86AudioMute allow-when-locked=true repeat=false { spawn-sh "mv-mute"; }
          XF86AudioMicMute allow-when-locked=true repeat=false { spawn-sh "mv-mic"; }

          XF86AudioPlay allow-when-locked=true repeat=false { spawn-sh "playerctl -p playerctld play"; }
          XF86AudioPause allow-when-locked=true repeat=false { spawn-sh "playerctl -p playerctld pause"; }
          XF86AudioPrev allow-when-locked=true repeat=false { spawn-sh "playerctl -p playerctld position 10-"; }
          XF86AudioNext allow-when-locked=true repeat=false { spawn-sh "playerctl -p playerctld position 10+"; }
          XF86AudioForward allow-when-locked=true repeat=false { spawn-sh "playerctl -p playerctld next"; }
          XF86AudioRewind allow-when-locked=true repeat=false { spawn-sh "playerctl -p playerctld previous"; }

          Mod+Shift+Q repeat=false { close-window; }

          Mod+A { spawn-sh "notify-send '色' \"$(hyprpicker -f rgb -a)\""; }
          Mod+H { focus-column-left; }
          Mod+J { focus-window-or-workspace-down; }
          Mod+K { focus-window-or-workspace-up; }
          Mod+L { focus-column-right; }

          Mod+Shift+H { move-column-left; }
          Mod+Shift+J { move-window-down-or-to-workspace-down; }
          Mod+Shift+K { move-window-up-or-to-workspace-up; }
          Mod+Shift+L { move-column-right; }

          Mod+Left { focus-monitor-left; }
          Mod+Right { focus-monitor-right; }

          Mod+Shift+Left { move-workspace-to-monitor-left; }
          Mod+Shift+Right { move-workspace-to-monitor-right; }

          Mod+WheelScrollDown { focus-column-right; }
          Mod+WheelScrollUp { focus-column-left; }
          Mod+Shift+WheelScrollDown { move-column-right; }
          Mod+Shift+WheelScrollUp { move-column-left; }
          MouseForward { focus-workspace-up; }
          MouseBack { focus-workspace-down; }

          Mod+1 { focus-workspace-up; }
          Mod+2 { focus-workspace-down; }
          Mod+3 { focus-column-left; }
          Mod+4 { focus-column-right; }
          Mod+5 repeat=false { toggle-overview; }
          Mod+Shift+1 { move-column-to-workspace-up; }
          Mod+Shift+2 { move-column-to-workspace-down; }
          Mod+Shift+3 { move-column-left; }
          Mod+Shift+4 { move-column-right; }

          Mod+Semicolon { consume-or-expel-window-left; }
          Mod+Shift+Semicolon { consume-or-expel-window-right; }

          Mod+W { spawn-sh "~/.config/${randomBackgroundScript}"; }
          Mod+Shift+W { spawn-sh "~/.config/hypr/swap-bg.fish"; }

          Mod+R { switch-preset-column-width; }
          Mod+Shift+R { switch-preset-window-height; }
          Mod+Ctrl+R { reset-window-height; }
          Mod+F { maximize-column; }
          Mod+Shift+F { fullscreen-window; }

          Mod+C { center-column; }

          Mod+Minus { set-column-width "-10%"; }
          Mod+Equal { set-column-width "+10%"; }
          Mod+Shift+Minus { set-window-height "-10%"; }
          Mod+Shift+Equal { set-window-height "+10%"; }

          Mod+V { toggle-window-floating; }
          Mod+Shift+V { switch-focus-between-floating-and-tiling; }

          Mod+Ctrl+W { toggle-column-tabbed-display; }

          Print { screenshot; }
          Ctrl+Print { screenshot-screen; }
          Alt+Print { screenshot-window; }

          Mod+Escape allow-inhibiting=false { toggle-keyboard-shortcuts-inhibit; }

          Mod+Shift+E { quit; }
          Ctrl+Alt+Delete { quit; }
          Mod+Shift+P { power-off-monitors; }
        }
      '';

    ${setBackgroundScript} = {
      executable = true;
      text = # fish
        ''
          #!/usr/bin/env fish

          awww img \
            --transition-type $(random choice grow wave outer) \
            --transition-wave 80,40 \
            --transition-angle $(random choice 45 90 135 225 270 315) \
            --transition-pos $(random choice center top left right bottom top-left top-right bottom-left bottom-right) \
            --transition-step 200 \
            --transition-duration 1.5 \
            --transition-fps 240 \
            --outputs "$argv[1]" \
            "$argv[2]"
        '';
    };

    ${randomBackgroundScript} = {
      executable = true;
      text = # fish
        ''
          #!/usr/bin/env fish

          set LATEST $(ls -1 ${osu-backgrounds} | tail -n 1)

          for monitor in (niri msg -j outputs | jq -r '.[].name')
            ~/.config/${setBackgroundScript} "$monitor" "$(random choice $(fd . ${osu-backgrounds}/$LATEST --follow -e jpg -e jpeg -e png))"
          end
        '';
    };
  };
}
