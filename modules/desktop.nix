{ nix-config, pkgs, config, lib, ... }:

let
  inherit (lib) mkEnableOption mkIf mkMerge mkOption;
  inherit (lib.types) float int;
  inherit (config.modules.system) username;
  inherit (cfg) bloat gnome plasma container opacity fontSize graphical phone phosh;
  inherit (nix-config.packages.${pkgs.system}) aleo-fonts;
  inherit (pkgs) phinger-cursors noto-fonts-cjk-sans maple-mono noto-fonts-emoji;
  inherit (builtins) attrValues;

  legacyHyprland = pkgs.hyprland.override {
    legacyRenderer = true;
  };

  cfg = config.modules.desktop;
in
{
  imports = attrValues {
    inherit (nix-config.inputs.home-manager.nixosModules) home-manager;
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
    phone = mkEnableOption "Phone support";
    gnome = mkEnableOption "GNOME specialization";
    plasma = mkEnableOption "Plasma specialization";
    container = mkEnableOption "disable some options for container performance";
    graphical = mkEnableOption "xserver for graphical containers";
    phosh = mkEnableOption "use phosh instead of hyprland";
  };

  config = {
    hardware.opengl.driSupport32Bit = mkIf (!phone) true;

    programs = {
      hyprland.enable = mkIf (!container) true;
      cdemu.enable = mkIf (!phone) true;

      thunar = {
        enable = true;

        plugins = attrValues {
          inherit (pkgs.xfce) thunar-volman;
        };
      };
    };

    i18n.inputMethod = mkIf (!phosh) {
      enabled = "fcitx5";

      fcitx5 = {
        addons = with pkgs; [ fcitx5-mozc ];
        waylandFrontend = true;
      };
    };

    services = {
      udisks2 = mkIf (!phone) {
        enable = true;
        mountOnMedia = true;
      };

      xserver = mkIf (!container || graphical) {
        enable = true;
        excludePackages = [ pkgs.xterm ];

        displayManager.lightdm.enable = mkIf phosh false;

        desktopManager.phosh = mkIf phosh {
          enable = true;
          group = "users";
          user = username;
        };
      };

      pipewire = mkIf (!phosh) {
        enable = true;

        alsa = {
          enable = true;
          support32Bit = mkIf (!phone) true;
        };

        pulse.enable = true;
      };

      greetd = mkIf (!container && !phosh) {
        enable = true;
        restart = false;

        settings = {
          default_session = {
            command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland --time-format '%F %R'";
            user = "greeter";
          };

          initial_session = {
            command = "${if phone then legacyHyprland else pkgs.hyprland}/bin/Hyprland";
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
      (mkIf bloat (attrValues {
        inherit (pkgs)
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
          qbittorrent
          obs-studio
          popsicle
          satty
          aaaaxy
          srb2
          ringracers
          jamesdsp
          ;
      }))

      (mkIf (!phone) (attrValues {
        inherit (nix-config.inputs.sakaya.packages.${pkgs.system}) sakaya;
        inherit (pkgs) texliveFull;
      }))

      (mkIf phone (attrValues {
        inherit (pkgs.gnome)
          eog
          geary
          gnome-calculator
          gnome-calendar
          gnome-characters
          gnome-disk-utility
          gnome-font-viewer
          gnome-contacts
          gnome-clocks
          gnome-chess
          gnome-sudoku
          gnome-weather
          gnome-sound-recorder
          gnome-maps
          nautilus
          ;
        inherit (pkgs)
          flare-signal
          gurk-rs
          android-tools
          chatty
          gnome-console
          megapixels
          wvkbd
          maliit-keyboard
          squeekboard
          animatch
          audio-sharing
          authenticator
          badwolf
          blackbox
          blanket
          cpupower-gui
          gnome-2048
          snapshot
          castor
          celluloid
          chess-clock
          clapper
          collision
          contrast
          cozy
          delfin
          dialect
          done
          deja-dup
          entangle
          gnome-feeds
          flowtime
          folio
          fractal
          freetube
          gnome-frog
          furtherance
          g4music
          gnuchess
          giara
          glide-media-player
          gnote
          goodvibes
          gnome-graphs
          health
          identity
          image-roll
          loupe
          imaginer
          iotas
          kana
          karlender
          khronos
          komikku
          livi
          localsend
          lollypop
          lorem
          marble
          marker
          mepo
          metadata-cleaner
          monophony
          mousai
          muzika
          newsflash
          notejot
          numberstation
          papers
          parabolic
          passes
          phosh-mobile-settings
          pika-backup
          planify
          portfolio
          powersupply
          ptyxis
          pure-maps
          read-it-later
          resources
          shattered-pixel-dungeon
          sgt-puzzles
          smile
          solanum
          stellarium
          tangram
          tuba
          unciv
          gnome-usage
          warp
          whatip
          wike
          wildcard
          wordbook
          caerbannog
          shipments
          drawing
          markets
          ;
      }))

      (attrValues {
        inherit (pkgs) anki kanjidraw pulseaudio glib;
        inherit (pkgs.xfce) exo;
      })
    ];

    fonts = {
      enableDefaultPackages = false;

      packages = with pkgs; [
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-cjk-serif
        noto-fonts-emoji
        maple-mono
        font-awesome
        (nerdfonts.override { fonts = [ "Noto" ]; })
        kanji-stroke-order-font
        liberation_ttf
        aleo-fonts
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
      base16Scheme = ../assets/selenized-black.yaml;

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

    specialisation = {
      gnome = mkIf gnome {
        configuration.imports = [ ../specializations/gnome.nix ];
      };

      plasma = mkIf plasma {
        configuration.imports = [ ../specializations/plasma.nix ];
      };
    };
  };
}
