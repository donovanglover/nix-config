{ pkgs, config, lib, ... }:

let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.modules.desktop;
in
{
  options.modules.desktop = {
    japanese = mkEnableOption "Japanese support (fcitx, anki, kanjidraw, etc.)";
    bloat = mkEnableOption "GUI applications like Logseq";
  };

  config = with cfg; {
    programs.hyprland.enable = true;

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
  };
}
