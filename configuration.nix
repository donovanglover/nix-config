{ config, pkgs, lib, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  networking.networkmanager.unmanaged = [ "interface-name:ve-*" ];
  networking.networkmanager.dns = "none";
  networking.useHostResolvConf = true;

  services.vnstat.enable = true;
  services.tumbler.enable = true;
  services.xserver.displayManager.sddm.enable = true;

  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;
  environment.shells = with pkgs; [ fish ];

  time.timeZone = "America/New_York";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.supportedLocales =
    [ "en_US.UTF-8/UTF-8" "ja_JP.UTF-8/UTF-8" "fr_FR.UTF-8/UTF-8" ];

  services.xserver.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  programs.thunar.enable = true;

  programs.starship.enable = true;
  programs.neovim.enable = true;
  programs.hyprland.enable = true;
  programs.git.enable = true;
  programs.firejail.enable = true;

  nix.package = pkgs.nixFlakes;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  environment.systemPackages = with pkgs; [
    fluent-icon-theme
    fluent-gtk-theme
    maple-mono-NF
    tmux
    fish
    wget
    librewolf
    kitty
    mullvad-vpn
    mullvad-browser
    papirus-icon-theme
    mediainfo
    pywal
    mpv
    neofetch
    anki
    htop-vim
    logseq
    wl-clipboard
    sox
    spek
    ripgrep
    phinger-cursors
    rsync
    jq
    keepassxc
    feh
    stow
    lf
    exa
    fd
    fzf
    unar
    gdu
    ranger
    nixfmt
    whois
    wofi
  ];

  fonts.enableDefaultFonts = true;
  fonts.fonts = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-emoji
    hack-font
  ];

  fonts.fontconfig = {
    defaultFonts = {
      serif = [ "Noto Serif CJK JP" "Noto Serif" ];
      sansSerif = [ "Noto Sans CJK JP" "Noto Sans" ];
      monospace = [ "Noto Mono CJK JP" "Noto Mono" ];
    };
  };

  fonts.fontconfig.hinting.style = "hintfull";

  i18n.inputMethod = {
    enabled = "ibus";
    ibus.engines = with pkgs.ibus-engines; [ anthy mozc ];
  };

  services.gnome.core-utilities.enable = false;
  services.mullvad-vpn.enable = true;
  services.mullvad-vpn.enableExcludeWrapper = false;

  networking.networkmanager.wifi.macAddress = "random";
  networking.networkmanager.ethernet.macAddress = "random";
  services.resolved.llmnr = "false";

  environment.defaultPackages = [ ];
  environment.gnome.excludePackages = [ pkgs.gnome-tour ];
  services.xserver.excludePackages = [ pkgs.xterm ];
  services.gnome.gnome-online-accounts.enable = false;
  services.gnome.gnome-user-share.enable = false;
  services.gnome.tracker.enable = false;
  services.gnome.tracker-miners.enable = false;

  # Force containers to use mullvad
  networking.nat.enable = true;
  networking.nat.internalInterfaces = ["ve-+"];
  networking.nat.externalInterface = "wg-mullvad";

  services.interception-tools = {
    enable = true;
    plugins = [ pkgs.interception-tools-plugins.dual-function-keys ];
    udevmonConfig = ''
      - JOB: "${pkgs.interception-tools}/bin/intercept -g $DEVNODE | ${pkgs.interception-tools-plugins.dual-function-keys}/bin/dual-function-keys -c /etc/dual-function-keys.yaml | ${pkgs.interception-tools}/bin/uinput -d $DEVNODE"
        DEVICE:
          EVENTS:
            EV_KEY: [KEY_CAPSLOCK, KEY_ESC]
    '';
  };

  environment.etc."dual-function-keys.yaml".text = ''
    TIMING:
        - TAP_MILLISEC: 1000
        - DOUBLE_TAP_MILLISEC: 0
    MAPPINGS:
        - KEY: KEY_CAPSLOCK
          TAP: KEY_ESC
          HOLD: KEY_LEFTCTRL
        - KEY: KEY_SYSRQ
          TAP: KEY_SYSRQ
          HOLD: KEY_RIGHTMETA
  '';

  containers.test = let hostCfg = config;
  in {
    autoStart = true;
    privateNetwork = true;
    hostAddress = "192.168.100.10";
    localAddress = "192.168.100.11";

    bindMounts = {
      waylandDisplay = rec {
        hostPath = "/run/user/1000";
        mountPoint = hostPath;
      };
    };

    config = { config, pkgs, ... }: {
      programs.fish.enable = true;
      users.defaultUserShell = pkgs.fish;
      environment.shells = with pkgs; [ fish ];

      programs.npm.enable = true;

      nix.package = pkgs.nixFlakes;
      nix.settings.experimental-features = [ "nix-command" "flakes" ];
      environment.systemPackages = with pkgs; [
        p7zip
        kitty
        neovim
        git
        unzip
        ripgrep
        gcc
        trashy
        mullvad-browser
        alacritty
        logseq
        feh
        wget
        exa
        fd
        fzf
        gdu
        ranger
        wofi
        lf
      ];

      environment.variables = { TERM = "xterm-kitty"; };

      environment.sessionVariables = {
        # WAYLAND_DISPLAY = "wayland-0"; # GNOME+gdm
        WAYLAND_DISPLAY = "wayland-1"; # Hyprland+sddm
        QT_QPA_PLATFORM = "wayland";
        QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
        SDL_VIDEODRIVER = "wayland";
        CLUTTER_BACKEND = "wayland";
        MOZ_ENABLE_WAYLAND = "1";
        XDG_RUNTIME_DIR = "/run/user/1000";
        # DISPLAY = ":0"; # GNOME+gdm
        DISPLAY = ":1"; # Hyprland+sddm
      };

      services.xserver.enable = true;

      hardware.opengl = {
        enable = true;
        extraPackages = hostCfg.hardware.opengl.extraPackages;
      };

      users.mutableUsers = false;
      users.allowNoPasswordLogin = true;

      users.users.user = {
        isNormalUser = true;
        home = "/home/user";
      };

      environment.defaultPackages = [ ];
      system.stateVersion = "22.11";
    };
  };

  system.stateVersion = "22.11";
}
