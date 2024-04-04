{ pkgs, config, lib, ... }:

let
  inherit (lib) mkEnableOption mkIf;
  inherit (pkgs.xfce) thunar-volman exo;
  inherit (pkgs) glib;

  theme = "monokai";
  opacity = 0.95;
  font-size = 11;

  cfg = config.modules.desktop;
in
{
  options.modules.desktop = {
    japanese = mkEnableOption "Japanese support (fcitx, anki, kanjidraw, etc.)";
    bloat = mkEnableOption "GUI applications like Logseq";
  };

  config = with cfg; {
    programs = {
      hyprland.enable = true;

      thunar = {
        enable = true;
        plugins = [ thunar-volman ];
      };
    };

    i18n.inputMethod = mkIf japanese {
      enabled = "fcitx5";

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

      xserver = {
        enable = true;
        excludePackages = [ pkgs.xterm ];
      };

      pipewire = {
        enable = true;

        alsa = {
          enable = true;
          support32Bit = true;
        };

        pulse.enable = true;
      };

      tumbler.enable = true;
      gvfs.enable = true;
      gnome.gnome-keyring.enable = true;
    };

    environment.systemPackages = with pkgs; [
      pulseaudio
      anki
      kanjidraw
      logseq
      mullvad-browser
      spek
      audacity
      gimp
      sqlitebrowser
      qdirstat
      libreoffice
      krita
      element-desktop
      signal-desktop
      ungoogled-chromium
      qbittorrent
      exo
      glib
    ];

    services.greetd = {
      enable = true;
      restart = false;

      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland";
          user = "greeter";
        };

        initial_session = {
          command = "${pkgs.hyprland}/bin/Hyprland";
          user = "user";
        };
      };
    };

    fonts = {
      enableDefaultPackages = false;

      packages = with pkgs; [
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-cjk-serif
        noto-fonts-emoji
        maple-mono
        font-awesome
        nerdfonts
        kanji-stroke-order-font
        liberation_ttf
      ];

      fontconfig = {
        defaultFonts = {
          serif = [ "Noto Serif CJK JP" "Noto Serif" ];
          sansSerif = [ "Noto Sans CJK JP" "Noto Sans" ];
          monospace = [ "Noto Sans Mono CJK JP" "Noto Sans Mono" ];
        };

        allowBitmaps = false;
      };
    };
    stylix = {
      image = ../assets/wallpaper.png;
      polarity = "dark";
      base16Scheme = "${pkgs.base16-schemes}/share/themes/${theme}.yaml";

      opacity = {
        terminal = opacity;
        popups = opacity;
      };

      cursor = with pkgs; {
        package = phinger-cursors;
        name = "phinger-cursors";
        size = 24;
      };

      fonts = with pkgs; {
        serif = {
          package = (callPackage ../packages/aleo-fonts.nix { });
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
          applications = font-size;
          desktop = font-size;
          popups = font-size;
          terminal = font-size;
        };
      };
    };
  };
}
