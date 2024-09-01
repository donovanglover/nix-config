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

      xserver = mkIf (!isContainer) {
        enable = true;
        excludePackages = with pkgs; [ xterm ];

        displayManager.startx.enable = mkIf (!isContainer) true;
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
          aleo-fonts
        ]
        ++ (with pkgs; [
          noto-fonts
          noto-fonts-cjk-serif
          noto-fonts-cjk-sans
          noto-fonts-emoji
          maple-mono
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
        package = pkgs.phinger-cursors;
        name = "phinger-cursors";
        size = 24;
      };

      fonts = {
        serif = {
          package = aleo-fonts;
          name = "Aleo";
        };

        sansSerif = {
          package = pkgs.noto-fonts-cjk-sans;
          name = "Noto Sans CJK JP";
        };

        monospace = {
          package = pkgs.maple-mono;
          name = "Maple Mono";
        };

        emoji = {
          package = pkgs.noto-fonts-emoji;
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
