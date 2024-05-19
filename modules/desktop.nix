{ nix-config, pkgs, config, lib, ... }:

let
  inherit (lib) mkEnableOption mkIf mkMerge mkOption;
  inherit (lib.types) str float int;
  inherit (config.modules.system) username;
  inherit (cfg) bloat gnome plasma container theme opacity fontSize;
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

    bloat = mkEnableOption "GUI applications like Logseq";
    gnome = mkEnableOption "GNOME specialization";
    plasma = mkEnableOption "Plasma specialization";
    container = mkEnableOption "disable some options for container performance";
  };

  config = {
    hardware.opengl.driSupport32Bit = true;

    programs = {
      hyprland.enable = mkIf (!container) true;
      cdemu.enable = true;

      thunar = {
        enable = true;

        plugins = attrValues {
          inherit (pkgs.xfce) thunar-volman;
        };
      };
    };

    i18n.inputMethod = {
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

      xserver = mkIf (!container) {
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

      greetd = mkIf (!container) {
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
          obs-studio
          satty
          aaaaxy
          srb2
          jamesdsp
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
        nerdfonts
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
