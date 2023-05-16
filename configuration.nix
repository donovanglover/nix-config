{ config, pkgs, lib, stylix, ... }:

{
  imports = [
    ./laptop.nix
    ./modules/starship.nix
    ./modules/fish.nix
    ./modules/fonts.nix
    ./modules/stylix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  services.xserver.displayManager.lightdm.enable = false;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  networking.networkmanager.unmanaged = [ "interface-name:ve-*" ];
  networking.networkmanager.dns = "none";
  networking.useHostResolvConf = true;
  services.udisks2.enable = true;
  security.pam.services.swaylock = { };

  systemd.extraConfig = ''
    DefaultTimeoutStopSec=10s
  '';

  virtualisation.vmVariant = {
    virtualisation = {
      memorySize = 8192;
      cores = 4;
    };
    virtualisation.qemu.options =
      [ "-device virtio-vga-gl" "-display sdl,gl=on" ];

    services.xserver.desktopManager.gnome.enable = true;
    services.xserver.displayManager.gdm.enable = true;

    i18n.inputMethod = lib.mkDefault {
      enabled = "ibus";
      ibus.engines = with pkgs.ibus-engines; [ mozc ];
    };

    services.gnome.core-utilities.enable = false;
    environment.gnome.excludePackages = [ pkgs.gnome-tour ];
    hardware.pulseaudio.enable = false;
  };

  environment.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    GIT_DISCOVERY_ACROSS_FILESYSTEM = "1";
    FZF_DEFAULT_OPTS = "--height 40% --reverse --border --color=16";
    NODE_OPTIONS = "--max_old_space_size=16384";
  };

  services.vnstat.enable = true;
  services.tumbler.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;
  environment.shells = with pkgs; [ fish ];
  programs.fish.shellAliases = {
    ls = "exa --group-directories-first -I 'lost+found'";
    tree =
      "exa --group-directories-first --all --long --tree -I 'node_modules|.git|public|lost+found'";
    mv = "mv -i";
    rg = "rg --max-columns=2000";
  };

  time.timeZone = "America/New_York";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.supportedLocales =
    [ "en_US.UTF-8/UTF-8" "ja_JP.UTF-8/UTF-8" "fr_FR.UTF-8/UTF-8" ];

  services.xserver.enable = true;
  programs.thunar.enable = true;

  programs.neovim.enable = true;
  programs.htop = {
    enable = true;
    package = pkgs."htop-vim";
    settings = { tree_view = 1; };
  };
  programs.firejail.enable = true;
  nix.package = pkgs.nixFlakes;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  environment.systemPackages = with pkgs; [
    pinentry-curses
    wget
    grim
    slurp
    librewolf
    kitty
    mullvad-vpn
    mullvad-browser
    papirus-icon-theme
    mediainfo
    pywal
    mpv
    mpc-cli
    neofetch
    tectonic
    fdupes
    anki
    logseq
    yt-dlp
    gurk-rs
    wl-clipboard
    ffmpeg
    siege
    ponysay
    lolcat
    figlet
    calcurse
    httpie
    cmatrix
    sox
    spek
    p7zip
    ripgrep
    rsync
    jq
    keepassxc
    stow
    exa
    fd
    fzf
    unar
    audacity
    gimp
    typespeed
    slade
    gdu
    ranger
    nixfmt
    whois
    lnch
    libnotify
    dwt1-shell-color-scripts
    tig
    dig
    trashy
    swaybg
    udiskie
    brightnessctl
    killall
    nodejs
    yarn
    deno
    crystal
    shards
    rustc
    rustfmt
    cargo
    genact
    xfce.exo
    (pkgs.callPackage ./pkgs/srb2.nix {})
  ];

  i18n.inputMethod.enabled = "fcitx5";
  i18n.inputMethod.fcitx5.addons = [ pkgs.fcitx5-mozc ];

  services.mullvad-vpn.enable = true;
  services.mullvad-vpn.enableExcludeWrapper = false;

  networking.networkmanager.wifi.macAddress = "random";
  networking.networkmanager.ethernet.macAddress = "random";
  services.resolved.llmnr = "false";

  environment.defaultPackages = [ ];
  services.xserver.excludePackages = [ pkgs.xterm ];

  # Force containers to use mullvad
  networking.nat.enable = true;
  networking.nat.internalInterfaces = [ "ve-+" ];
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

  system.stateVersion = "22.11";
}
