{
  nix-config,
  pkgs,
  config,
  lib,
  ...
}:

let
  inherit (lib.types) float int;
  inherit (config.modules.system) username;
  inherit (config.boot) isContainer;
  inherit (nix-config.packages.${pkgs.system}) aleo-fonts;
  inherit (builtins) attrValues;
  inherit (config.lib.stylix.colors.withHashtag) base00 base03 base05;

  inherit (lib)
    mkEnableOption
    mkIf
    mkMerge
    mkOption
    ;

  inherit (cfg)
    bloat
    opacity
    fontSize
    graphical
    ;

  inherit (pkgs)
    phinger-cursors
    noto-fonts-cjk-sans
    maple-mono
    noto-fonts-emoji
    ;

  stylix-background = nix-config.packages.${pkgs.system}.stylix-background.override {
    color = config.lib.stylix.colors.base00;
  };

  cfg = config.modules.desktop;
in
{
  imports = attrValues {
    inherit (nix-config.inputs.stylix.nixosModules) stylix;
  };

  options.modules.desktop = {
    opacity = mkOption {
      type = float;
      default = 0.95;
    };

    fontSize = mkOption {
      type = int;
      default = 11;
    };

    bloat = mkEnableOption "GUI applications";
    graphical = mkEnableOption "xserver for graphical containers";
  };

  config = {
    hardware.graphics.enable32Bit = true;

    programs = {
      hyprland.enable = mkIf (!isContainer) true;
      cdemu.enable = true;

      thunar = {
        enable = true;

        plugins = with pkgs.xfce; [ thunar-volman ];
      };
    };

    i18n.inputMethod = {
      enable = true;
      type = "fcitx5";

      fcitx5 = {
        addons = with pkgs; [ fcitx5-mozc ];
        waylandFrontend = true;
      };
    };

    services = {
      udisks2 = {
        enable = true;
        mountOnMedia = true;
      };

      libinput = {
        touchpad = {
          naturalScrolling = true;
          accelProfile = "flat";
          accelSpeed = "0.75";
        };

        mouse = {
          accelProfile = "flat";
        };
      };

      xserver = mkIf (!isContainer || graphical) {
        enable = true;
        excludePackages = with pkgs; [ xterm ];

        displayManager.startx.enable = mkIf (!isContainer) true;

        windowManager.dwm = mkIf (!isContainer) {
          enable = true;

          package = pkgs.dwm.override {
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
                static const char *print[] = { "scrot", NULL };
                static const char *up_vol[] = { "wpctl", "set-volume", "@DEFAULT_AUDIO_SINK@", "5%+", NULL };
                static const char *down_vol[] = { "wpctl", "set-volume", "@DEFAULT_AUDIO_SINK@", "5%-", NULL };
                static const char *mute_vol[] = { "wpctl", "set-mute", "@DEFAULT_AUDIO_SINK@", "toggle", NULL };

                static const Key keys[] = {
                  { 0, XF86XK_AudioMute, spawn, {.v = mute_vol } },
                  { 0, XF86XK_AudioLowerVolume, spawn, {.v = down_vol } },
                  { 0, XF86XK_AudioRaiseVolume, spawn, {.v = up_vol } },
                  { 0, XF86XK_MonBrightnessDown, spawn, {.v = dimmer } },
                  { 0, XF86XK_MonBrightnessUp, spawn, {.v = brighter } },
                  { 0, XK_Print, spawn, {.v = print } },
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
                url = "https://raw.githubusercontent.com/bakkeby/patches/c5eae9d/dwm/dwm-desktop_icons-6.5.diff";
                hash = "sha256-oIgeph9pmIWKBepnQhc+aNWU7ZHxsJbhJr5LVNTtuHc=";
              })
            ];
          };
        };
      };

      pipewire = {
        enable = true;

        alsa = {
          enable = true;
          support32Bit = true;
        };

        pulse.enable = true;
      };

      greetd = mkIf (!isContainer) {
        enable = true;
        restart = false;

        settings = {
          default_session = {
            command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland --time-format '%F %R'";
            user = "greeter";
          };

          initial_session = {
            command = "${pkgs.hyprland}/bin/Hyprland";
            user = username;
          };
        };
      };

      tumbler.enable = true;
      gvfs.enable = true;
      gnome.gnome-keyring.enable = true;
      upower.enable = true;
    };

    environment.systemPackages = mkMerge [
      (mkIf bloat (
        with pkgs;
        [
          mullvad-browser
          spek
          audacity
          gimp
          libreoffice
          element-desktop
          signal-desktop
          qbittorrent
          popsicle
          satty
          srb2
          ringracers
          jamesdsp
          texliveFull
        ]
      ))

      (mkIf (pkgs.system == "x86_64-linux") (
        with nix-config.inputs.sakaya.packages.${pkgs.system}; [ sakaya ]
      ))

      (with pkgs; [
        anki
        pulseaudio
        grim
        wl-clipboard-rs
      ])
    ];

    fonts = {
      enableDefaultPackages = false;

      packages =
        [
          noto-fonts-cjk-sans
          noto-fonts-emoji
          maple-mono
          aleo-fonts
        ]
        ++ (with pkgs; [
          noto-fonts
          noto-fonts-cjk-serif
          font-awesome
          (nerdfonts.override { fonts = [ "Noto" ]; })
          kanji-stroke-order-font
          liberation_ttf
        ]);

      fontconfig = {
        defaultFonts = {
          serif = [
            "Noto Serif CJK JP"
            "Noto Serif"
          ];

          sansSerif = [
            "Noto Sans CJK JP"
            "Noto Sans"
          ];

          monospace = [
            "Noto Sans Mono CJK JP"
            "Noto Sans Mono"
          ];
        };

        allowBitmaps = false;
      };
    };

    stylix = {
      enable = true;
      image = "${stylix-background}/wallpaper.png";
      polarity = "dark";
      base16Scheme = {
        system = "base16";
        name = "selenized-black";
        author = "Jan Warchol (https://github.com/jan-warchol/selenized) / adapted to base16 by ali";
        variant = "dark";

        palette = {
          base00 = "181818";
          base01 = "252525";
          base02 = "3b3b3b";
          base03 = "777777";
          base04 = "777777";
          base05 = "b9b9b9";
          base06 = "dedede";
          base07 = "dedede";
          base08 = "ed4a46";
          base09 = "e67f43";
          base0A = "dbb32d";
          base0B = "70b433";
          base0C = "3fc5b7";
          base0D = "368aeb";
          base0E = "a580e2";
          base0F = "eb6eb7";
        };
      };

      opacity = {
        terminal = opacity;
        popups = opacity;
      };

      cursor = {
        package = phinger-cursors;
        name = "phinger-cursors";
        size = 24;
      };

      fonts = {
        serif = {
          package = aleo-fonts;
          name = "Aleo";
        };

        sansSerif = {
          package = noto-fonts-cjk-sans;
          name = "Noto Sans CJK JP";
        };

        monospace = {
          package = maple-mono;
          name = "Maple Mono";
        };

        emoji = {
          package = noto-fonts-emoji;
          name = "Noto Color Emoji";
        };

        sizes = {
          applications = fontSize;
          desktop = fontSize;
          popups = fontSize;
          terminal = fontSize;
        };
      };
    };
  };
}
