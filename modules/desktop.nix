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
  inherit (config.lib.stylix.colors.withHashtag) base00;
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
    gnome
    plasma
    container
    opacity
    fontSize
    graphical
    ;

  inherit (pkgs)
    phinger-cursors
    noto-fonts-cjk-sans
    maple-mono
    noto-fonts-emoji
    stdenvNoCC
    imagemagick
    ;

  stylix-background = stdenvNoCC.mkDerivation {
    pname = "stylix-background";
    version = base00;

    dontUnpack = true;

    nativeBuildInputs = [ imagemagick ];

    postInstall = ''
      mkdir -p $out
      magick -size 1x1 xc:${base00} $out/wallpaper.png
    '';
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
    gnome = mkEnableOption "GNOME specialization";
    plasma = mkEnableOption "Plasma specialization";
    container = mkEnableOption "disable some options for container performance";
    graphical = mkEnableOption "xserver for graphical containers";
  };

  config = {
    hardware.graphics.enable32Bit = true;

    programs = {
      hyprland.enable = mkIf (!container) true;
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

    virtualisation.libvirtd = {
      enable = true;
      onBoot = "ignore";
    };

    services = {
      udisks2 = {
        enable = true;
        mountOnMedia = true;
      };

      xserver = mkIf (!container || graphical) {
        enable = true;
        excludePackages = with pkgs; [ xterm ];
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
          vagrant
          ;

        inherit (nix-config.inputs.sakaya.packages.${pkgs.system}) sakaya;
      }))

      (attrValues {
        inherit (pkgs)
          anki
          pulseaudio
          glib
          grim
          wl-clipboard-rs
          ;

        inherit (pkgs.xfce) exo;
      })
    ];

    nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [ "vagrant" ];

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
      gnome = mkIf gnome { configuration.imports = [ ../specializations/gnome.nix ]; };
      plasma = mkIf plasma { configuration.imports = [ ../specializations/plasma.nix ]; };
    };
  };
}
