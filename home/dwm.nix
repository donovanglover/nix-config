{
  nixosConfig,
  config,
  pkgs,
  ...
}:

let
  inherit (nixosConfig._module.specialArgs) nix-config;

  inherit (config.lib.stylix.colors.withHashtag) base00 base03 base05;
  inherit (config.home) homeDirectory;

  inherit (nix-config.packages.${pkgs.system})
    osu-backgrounds
    dunst-scripts
    ;

  barScript = "dwm/bar.fish";
  wallpaperScript = "dwm/wallpaper.fish";
  areaScript = "dwm/area.fish";
in
{
  home = {
    packages = with pkgs; [
      feh
      xclip
      scrot
      maim
      mpdris2

      (dwm.override {
        conf = # c
          ''
            #include <X11/XF86keysym.h>

            static const unsigned int borderpx = 0;
            static const unsigned int snap = 32;
            static const int user_bh = 10;
            static const int showbar = 1;
            static const int topbar = 1;

            static const char *fonts[] = {
              "Maple Mono:size=10",
              "Noto Sans Mono CJK JP:size=10",
              "Noto Color Emoji:size=10",
            };

            static const char *colors[][3] = {
              [SchemeNorm] = { "${base03}", "${base00}", "${base03}" },
              [SchemeSel] = { "${base05}", "${base00}", "${base05}" },
            };

            static const char *const autostart[] = {
              "xrdb", "-merge", "${homeDirectory}/.Xresources", NULL,
              "mpDris2", NULL,
              "dunst", NULL,
              "picom", NULL,
              "fcitx5", NULL,
              "xset", "r", "rate", "300", "50", NULL,
              "xset", "-dpms", NULL,
              "fish", "${homeDirectory}/.config/${barScript}", NULL,
              "fish", "${homeDirectory}/.config/${wallpaperScript}", NULL,
              "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1", NULL,
              NULL
            };

            static const unsigned int baralpha = 243;

            static const unsigned int alphas[][3] = {
              [SchemeNorm] = { OPAQUE, baralpha, baralpha },
              [SchemeSel] = { OPAQUE, baralpha, baralpha },
            };

            static const char *tags[] = { "⬤", "⬤", "⬤", "⬤", "⬤", "⬤" };

            static const Rule rules[] = {
              { "librewolf", NULL, NULL, 0, 1, -1 },
            };

            static const float mfact = 0.55;
            static const int nmaster = 1;
            static const int resizehints = 1;
            static const int lockfullscreen = 1;

            static const Layout layouts[] = {
              { "[]=", tile },
            };

            #define MODKEY Mod4Mask

            static char dmenumon[2] = "0";
            static const char *dmenucmd[] = { "rofi", "-show", NULL };
            static const char *quitcmd[] = { "kill", "xinit", NULL };
            static const char *termcmd[] = { "kitty", NULL };
            static const char *explorercmd[] = { "kitty", "yazi", NULL };
            static const char *brighter[] = { "${dunst-scripts}/bin/mb-up", NULL };
            static const char *dimmer[] = { "${dunst-scripts}/bin/mb-down", NULL };
            static const char *print[] = { "scrot", NULL };
            static const char *up_vol[] = { "${dunst-scripts}/bin/mv-up", NULL };
            static const char *down_vol[] = { "${dunst-scripts}/bin/mv-down", NULL };
            static const char *mute_vol[] = { "${dunst-scripts}/bin/mv-mute", NULL };
            static const char *mute_mic[] = { "${dunst-scripts}/bin/mv-mic", NULL };
            static const char *wallpaper[] = { "fish", "${homeDirectory}/.config/${wallpaperScript}", NULL };
            static const char *area[] = { "fish", "${homeDirectory}/.config/${areaScript}", NULL };
            static const char *audio_prev[] = { "playerctl", "-p", "playerctld", "previous", NULL };
            static const char *audio_next[] = { "playerctl", "-p", "playerctld", "next", NULL };
            static const char *audio_play_pause[] = { "playerctl", "-p", "playerctld", "play-pause", NULL };
            static const char *audio_forward[] = { "playerctl", "-p", "playerctld", "position", "10+", NULL };
            static const char *audio_rewind[] = { "playerctl", "-p", "playerctld", "position", "10-", NULL };

            static const Key keys[] = {
              { 0, XF86XK_AudioMute, spawn, {.v = mute_vol } },
              { 0, XF86XK_AudioMicMute, spawn, {.v = mute_mic } },
              { 0, XF86XK_AudioLowerVolume, spawn, {.v = down_vol } },
              { 0, XF86XK_AudioRaiseVolume, spawn, {.v = up_vol } },
              { 0, XF86XK_MonBrightnessDown, spawn, {.v = dimmer } },
              { 0, XF86XK_MonBrightnessUp, spawn, {.v = brighter } },
              { 0, XF86XK_AudioPrev, spawn, {.v = audio_prev } },
              { 0, XF86XK_AudioNext, spawn, {.v = audio_next } },
              { 0, XF86XK_AudioPlay, spawn, {.v = audio_play_pause } },
              { 0, XF86XK_AudioPause, spawn, {.v = audio_play_pause } },
              { 0, XF86XK_AudioForward, spawn, {.v = audio_forward } },
              { 0, XF86XK_AudioRewind, spawn, {.v = audio_rewind } },
              { 0, XK_Print, spawn, {.v = area } },
              { MODKEY, XK_bracketleft, spawn, {.v = dmenucmd } },
              { MODKEY, XK_bracketright, spawn, {.v = explorercmd } },
              { MODKEY, XK_o, togglebar, {0} },
              { MODKEY, XK_f, togglefullscr, {0} },
              { MODKEY, XK_v, togglefloating, {0} },
              { MODKEY, XK_j, focusstack, {.i = +1 } },
              { MODKEY, XK_k, focusstack, {.i = -1 } },
              { MODKEY, XK_m, tagmon, {.i = +1 } },
              { MODKEY, XK_p, spawn, {.v = print } },
              { MODKEY, XK_w, spawn, {.v = wallpaper } },
              { MODKEY, XK_Return, zoom, {0} },
              { MODKEY, XK_comma, focusmon, {.i = -1 } },
              { MODKEY, XK_period, focusmon, {.i = +1 } },
              { MODKEY, XK_1, viewprev, {0} },
              { MODKEY, XK_2, viewnext, {0} },
              { MODKEY|ShiftMask, XK_1, tagtoprev, {0} },
              { MODKEY|ShiftMask, XK_1, reorganizetags, {0} },
              { MODKEY|ShiftMask, XK_2, tagtonext, {0} },
              { MODKEY|ShiftMask, XK_2, reorganizetags, {0} },
              { MODKEY|ShiftMask, XK_m, tagmon, {.i = -1 } },
              { MODKEY|ShiftMask, XK_h, setmfact, {.f = -0.05} },
              { MODKEY|ShiftMask, XK_l, setmfact, {.f = +0.05} },
              { MODKEY|ShiftMask, XK_Return, spawn, {.v = termcmd } },
              { MODKEY|ShiftMask, XK_q, killclient, {0} },
              { MODKEY|Mod1Mask, XK_Delete, spawn, {.v = quitcmd } },
            };

            static const Button buttons[] = {
              { ClkTagBar, 0, Button1, view, {0} },
              { ClkClientWin, MODKEY, Button1, movemouse, {0} },
              { ClkClientWin, MODKEY, Button3, resizemouse, {0} },
            };
          '';

        patches = with pkgs; [
          ../assets/dwm-actualfullscreen.patch
          ../assets/dwm-adjacenttag.patch
          ../assets/dwm-remove-layout-indicator.patch
          ../assets/dwm-remove-floating-indicator.patch
          ../assets/dwm-savefloats-alwayscenter.patch

          (fetchpatch {
            url = "https://dwm.suckless.org/patches/hide_vacant_tags/dwm-hide_vacant_tags-6.4.diff";
            hash = "sha256-GIbRW0Inwbp99rsKLfIDGvPwZ3pqihROMBp5vFlHx5Q=";
          })

          (fetchpatch {
            url = "https://dwm.suckless.org/patches/alpha/dwm-alpha-20230401-348f655.diff";
            hash = "sha256-ZhuqyDpY+nQQgrjniQ9DNheUgE9o/MUXKaJYRU3Uyl4=";
          })

          (fetchpatch {
            url = "https://dwm.suckless.org/patches/reorganizetags/dwm-reorganizetags-6.2.diff";
            hash = "sha256-Fj+cfw+5d7i6UrakMbebhZsfmu8ZfooduQA08STovK4=";
          })

          (fetchpatch {
            url = "https://dwm.suckless.org/patches/bar_height/dwm-bar-height-spacing-6.3.diff";
            hash = "sha256-usMIMmloUG4NrX10AVbgr8kFs9ZG6Krn1NxXTVcLq70=";
          })

          (fetchpatch {
            url = "https://dwm.suckless.org/patches/cool_autostart/dwm-cool-autostart-20240312-9f88553.diff";
            hash = "sha256-pgXbgoAAewCjZP16smKkTVh5p7P/FK+Rue0F6gjmGVo=";
          })
        ];
      })
    ];

    file.".xinitrc" = {
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
          export GTK_CSD=0
          export QT_QPA_PLATFORMTHEME=qt5ct
          export QT_STYLE_OVERRIDE=kvantum

          while true; do
            dbus-launch --sh-syntax --exit-with-session dwm
          done
        '';
    };
  };

  xdg.configFile = {
    ${wallpaperScript} = {
      executable = true;
      text = # fish
        ''
          #!/usr/bin/env fish

          feh --bg-fill \
            (random choice (fd . ${osu-backgrounds}/2025-04-01-Springtime-Showdown-Art-Contest-All-Entries --follow -e jpg -e png)) \
            (random choice (fd . ${osu-backgrounds}/2025-04-01-Springtime-Showdown-Art-Contest-All-Entries --follow -e jpg -e png))
        '';
    };

    ${barScript} = {
      executable = true;
      text = # fish
        ''
          #!/usr/bin/env fish

          function get_icon
            if test "$argv" -gt 90
              echo " "
            else if test "$argv" -gt 60
              echo " "
            else if test "$argv" -gt 30
              echo " "
            else if test "$argv" -gt 10
              echo " "
            else
              echo " "
            end
          end

          function update_bar
            set VOL $(wpctl get-volume @DEFAULT_AUDIO_SINK@)
            set MUTE $(echo "$VOL" | awk '{print $3}' | sed -e 's/\[MUTED\]/（ミュート）/' | tr --delete '\n')
            set VOLUME "音量：$(math "$(echo "$VOL" | choose 1) * 100")%"

            set TIME "$(date '+%x（%a）%R')"

            set capacity "$(cat /sys/class/power_supply/BAT0/capacity)"
            set BATTERY "$(get_icon $capacity)$capacity%"

            xsetroot -name " $MUTE$VOLUME・$BATTERY・$TIME "
          end

          while pidof dwm
            update_bar

            sleep 5s
          end
        '';
    };

    ${areaScript} = {
      executable = true;
      text = # fish
        ''
          #!/usr/bin/env fish

          maim -s | xclip -selection clipboard -t image/png
        '';
    };
  };
}
