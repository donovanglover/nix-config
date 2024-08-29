{
  dwm,
  fetchpatch,
  colorBackground ? "#222222",
  colorText ? "#bbbbbb",
  colorSelected ? "#eeeeee",
}:

dwm.override {
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
        [SchemeNorm] = { "${colorText}", "${colorBackground}", "${colorText}" },
        [SchemeSel] = { "${colorSelected}", "${colorBackground}", "${colorSelected}" },
      };

      static const unsigned int baralpha = 243;

      static const unsigned int alphas[][3] = {
        [SchemeNorm] = { OPAQUE, baralpha, baralpha },
        [SchemeSel] = { OPAQUE, baralpha, baralpha },
      };

      static const char *tags[] = { "⬤", "⬤", "⬤" };

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
      static const char *dmenucmd[] = { "rofi", "-show", "drun", NULL };
      static const char *quitcmd[] = { "kill", "xinit", NULL };
      static const char *termcmd[] = { "kitty", NULL };
      static const char *brighter[] = { "brightnessctl", "set", "5%+", NULL };
      static const char *dimmer[] = { "brightnessctl", "set", "5%-", NULL };
      static const char *up_vol[] = { "wpctl", "set-volume", "@DEFAULT_AUDIO_SINK@", "5%+", NULL };
      static const char *down_vol[] = { "wpctl", "set-volume", "@DEFAULT_AUDIO_SINK@", "5%-", NULL };
      static const char *mute_vol[] = { "wpctl", "set-mute", "@DEFAULT_AUDIO_SINK@", "toggle", NULL };

      static const Key keys[] = {
        { 0, XF86XK_AudioMute, spawn, {.v = mute_vol } },
        { 0, XF86XK_AudioLowerVolume, spawn, {.v = down_vol } },
        { 0, XF86XK_AudioRaiseVolume, spawn, {.v = up_vol } },
        { 0, XF86XK_MonBrightnessDown, spawn, {.v = dimmer } },
        { 0, XF86XK_MonBrightnessUp, spawn, {.v = brighter } },
        { MODKEY, XK_p, spawn, {.v = dmenucmd } },
        { MODKEY, XK_o, togglebar, {0} },
        { MODKEY, XK_f, togglefullscr, {0} },
        { MODKEY, XK_v, togglefloating, {0} },
        { MODKEY, XK_j, focusstack, {.i = +1 } },
        { MODKEY, XK_k, focusstack, {.i = -1 } },
        { MODKEY, XK_Return, zoom, {0} },
        { MODKEY, XK_comma, focusmon, {.i = -1 } },
        { MODKEY, XK_period, focusmon, {.i = +1 } },
        { MODKEY, XK_1, viewprev, {0} },
        { MODKEY, XK_2, viewnext, {0} },
        { MODKEY|ShiftMask, XK_1, tagtoprev, {0} },
        { MODKEY|ShiftMask, XK_1, reorganizetags, {0} },
        { MODKEY|ShiftMask, XK_2, tagtonext, {0} },
        { MODKEY|ShiftMask, XK_2, reorganizetags, {0} },
        { MODKEY|ShiftMask, XK_h, setmfact, {.f = -0.05} },
        { MODKEY|ShiftMask, XK_l, setmfact, {.f = +0.05} },
        { MODKEY|ShiftMask, XK_Return, spawn, {.v = termcmd } },
        { MODKEY|ShiftMask, XK_q, killclient, {0} },
        { MODKEY|ShiftMask, XK_comma, tagmon, {.i = -1 } },
        { MODKEY|ShiftMask, XK_period, tagmon, {.i = +1 } },
        { MODKEY|Mod1Mask, XK_Delete, spawn, {.v = quitcmd } },
      };

      static const Button buttons[] = {
        { ClkTagBar, 0, Button1, view, {0} },
        { ClkClientWin, MODKEY, Button1, movemouse, {0} },
        { ClkClientWin, MODKEY, Button3, resizemouse, {0} },
      };
    '';

  patches = [
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
      url = "https://raw.githubusercontent.com/bakkeby/patches/c5eae9d/dwm/dwm-desktop_icons-6.5.diff";
      hash = "sha256-oIgeph9pmIWKBepnQhc+aNWU7ZHxsJbhJr5LVNTtuHc=";
    })
  ];
}
