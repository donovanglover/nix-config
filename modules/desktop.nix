{
  pkgs,
  config,
  lib,
  ...
}:

let
  inherit (config.modules.system) username;
  inherit (config.boot) isContainer;

  inherit (lib)
    mkEnableOption
    mkIf
    mkMerge
    ;

  inherit (cfg) bloat;

  cfg = config.modules.desktop;
in
{
  options.modules.desktop = {
    bloat = mkEnableOption "GUI applications";
  };

  config = {
    hardware.graphics.enable32Bit = true;

    programs = {
      hyprland.enable = mkIf (!isContainer) true;
      cdemu.enable = true;

      thunar = {
        enable = true;

        plugins = with pkgs.xfce; [
          thunar-volman
        ];
      };
    };

    i18n.inputMethod = {
      enable = true;
      type = "fcitx5";

      fcitx5 = {
        waylandFrontend = true;

        addons = with pkgs; [
          fcitx5-mozc
        ];
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

        displayManager.startx.enable = true;
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

      (with pkgs; [
        anki
        pulseaudio
        pavucontrol
        grim
        wl-clipboard-rs
        antimicrox
        libnotify
      ])
    ];
  };
}
