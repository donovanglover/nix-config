{ nix-config, pkgs, config, lib, ... }:

let
  inherit (lib) mkEnableOption mkIf mkMerge mkOption;
  inherit (lib.types) str float int;
  inherit (config.modules.system) username phone;
  inherit (cfg) bloat gnome plasma container theme opacity fontSize graphical;
  inherit (nix-config.packages.${pkgs.system}) aleo-fonts;
  inherit (pkgs) phinger-cursors noto-fonts-cjk-sans maple-mono noto-fonts-emoji;
  inherit (builtins) attrValues;

  cfg = config.modules.desktop;
in
{
  imports = attrValues {
    inherit (nix-config.inputs.home-manager.nixosModules) home-manager;
    inherit (nix-config.inputs.stylix.nixosModules) stylix;

  };

  options.modules.desktop = {
    theme = mkOption {
      type = str;
      default = "monokai";
    };

    opacity = mkOption {
      type = float;
      default = 0.95;
    };

    fontSize = mkOption {
      type = int;
      default = 11;
    };

    bloat = mkEnableOption "GUI applications";
    gnome = mkEnableOption "GNOME specialization";
    plasma = mkEnableOption "Plasma specialization";
    container = mkEnableOption "disable some options for container performance";
    graphical = mkEnableOption "xserver for graphical containers";
  };

  config = {
    hardware = {
      opengl.driSupport32Bit = mkIf (!phone) true;

      pulseaudio = mkIf phone {
        enable = true;
        package = pkgs.pulseaudioFull;
      };

      bluetooth.enable = mkIf phone true;
      sensor.iio.enable = mkIf phone true;
    };

    programs = {
      hyprland.enable = mkIf (!container && !phone) true;
      cdemu.enable = true;
      calls.enable = mkIf phone true;

      thunar = {
        enable = true;

        plugins = attrValues {
          inherit (pkgs.xfce) thunar-volman;
        };
      };
    };

    i18n.inputMethod = mkIf (!phone) {
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

      xserver = mkIf (!container || graphical) {
        enable = true;
        excludePackages = [ pkgs.xterm ];

        desktopManager.phosh = mkIf phone {
          enable = true;
          user = username;
          group = "users";
        };
      };

      pipewire = mkIf (!phone) {
        enable = true;

        alsa = {
          enable = true;
          support32Bit = true;
        };

        pulse.enable = true;
      };

      greetd = mkIf (!container && !phone) {
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
          jamesdsp
          ;
      }))

      (mkIf phone (attrValues {
        inherit (pkgs)
          chatty
          megapixels
          ;
      }))

      (attrValues {
        inherit (pkgs) anki kanjidraw pulseaudio glib;
        inherit (nix-config.inputs.sakaya.packages.${pkgs.system}) sakaya;
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
      base16Scheme = "${pkgs.base16-schemes}/share/themes/${theme}.yaml";

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
