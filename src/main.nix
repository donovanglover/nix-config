{ pkgs
, lib
, hypr-contrib
, nix-gaming
, crystal-flake
, nixpkgs-hyprland-autoname-workspaces
, nixpkgs-srb2
, ...
}:

let VARIABLES = import ./variables.nix; in {
  imports = [
    "${VARIABLES.hostHardwareConfiguration}"
    ../overlays
    ../modules
    ../containers/rar.nix
    ../containers/wine.nix
    ../containers/dev.nix
    ../containers/gui.nix
    ../containers/srb2.nix
    ../containers/osu.nix
  ];

  # locale
  i18n.defaultLocale = VARIABLES.defaultLocale;
  i18n.supportedLocales = VARIABLES.supportedLocales;

  # nix
  nix.package = pkgs.nixFlakes;
  nix.settings.experimental-features = [ "nix-command" "flakes" "repl-flake" ];
  nix.settings.auto-optimise-store = true;

  hardware.opengl.driSupport32Bit = true;

  boot.loader = {
    systemd-boot = {
      enable = true;
      editor = false;
      configurationLimit = 10;
    };

    timeout = 0;
    efi.canTouchEfiVariables = true;
  };

  boot.tmp.useTmpfs = true;

  programs.gamemode = {
    enable = true;
    settings = {
      general = {
        renice = 10;
        igpu_power_threshold = -1;
      };

      custom = {
        start = "${pkgs.libnotify}/bin/notify-send 'Note' 'gamemode started from host.'";
        end = "${pkgs.libnotify}/bin/notify-send 'Note' 'gamemode ended from host.";
      };
    };
  };

  environment.systemPackages = with pkgs; [
    hypr-contrib.packages."${VARIABLES.system}".grimblast
    nix-gaming.packages."${VARIABLES.system}".osu-stable
    crystal-flake.packages.${VARIABLES.system}.crystal
    crystal-flake.packages.${VARIABLES.system}.crystalline
    ameba
    waycorner
    nwg-dock-hyprland
    slade
    typespeed
    osu-lazer-bin
    mullvad-vpn
    pass
    treefmt
    jamesdsp

    logseq
    mullvad-browser
    spek

    gdu
    fdupes
    mediainfo
    ponysay
    lolcat
    cmatrix
    sox
    httpie
    p7zip
    rsync
    unar
    genact
    ffmpeg
    killall
    trashy
    whois
    dwt1-shell-color-scripts
    dig
    yt-dlp
    neofetch
    pywal
    brightnessctl
    zellij
    librespeed-cli
    wiki-tui
    hexyl
    nb
    jpegoptim
    playerctl
    recode
    rmlint
    sd
    shards
    smartmontools
    visidata
    scc
    hwinfo
    stress
    choose
    gum
    hdparm
    imagemagick
    onefetch
    restic
    watchexec
    memento
    mpvpaper
    timg
    ventoy
    wf-recorder
    mdcat
    mdbook
    zola
    file
    tessen
    wtype
    mtr
    cointop

    grim
    slurp
    wl-clipboard
    lnch
    wev
    swww
    kickoff
    greetd.tuigreet
    nixpkgs-hyprland-autoname-workspaces.legacyPackages.${VARIABLES.system}.hyprland-autoname-workspaces
    nixpkgs-srb2.legacyPackages.${VARIABLES.system}.srb2
  ];

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "osu-lazer-bin"
      "vmware-workstation"
    ];

  environment.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    GIT_DISCOVERY_ACROSS_FILESYSTEM = "1";
    FZF_DEFAULT_OPTS = "--height 40% --reverse --border --color=16";
    NODE_OPTIONS = "--max_old_space_size=16384";
  };

  environment.defaultPackages = [ ];
  system.stateVersion = VARIABLES.stateVersion;

  # home-manager
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    sharedModules = [
      {
        home.stateVersion = VARIABLES.stateVersion;
      }
    ];
  };

  systemd.extraConfig = "DefaultTimeoutStopSec=10s"; # Prevent hanging on shutdown
  services.logind.lidSwitch = "ignore"; # Don't suspend on lid close
  time.timeZone = "${VARIABLES.timezone}"; # Timezone

  # user
  users = {
    mutableUsers = false;

    users."${VARIABLES.username}" = {
      isNormalUser = true;
      uid = 1000;
      password = "user";
      extraGroups = [ "wheel" "networkmanager" ];
    };
  };

  home-manager.users.user = {
    home.username = VARIABLES.username;
    home.homeDirectory = "/home/${VARIABLES.username}";
  };

  # networking
  networking = {
    hostName = VARIABLES.hostname;

    networkmanager = {
      enable = true;
      dns = "none";
      wifi.macAddress = "random";
      ethernet.macAddress = "random";

      unmanaged = [ "interface-name:ve-*" ];
    };

    useHostResolvConf = true;
  };

  services.resolved.llmnr = "false";

  systemd.services.NetworkManager-wait-online.enable = false;

  # virtualization
  virtualisation.vmVariant = {
    virtualisation = {
      memorySize = 8192;
      cores = 4;
      restrictNetwork = true;
    };

    virtualisation.qemu.options = [ "-device virtio-vga-gl" "-display sdl,gl=on,show-cursor=off" "-full-screen" ];

    environment.sessionVariables = {
      WLR_NO_HARDWARE_CURSORS = "1";
    };
  };

  # mullvad-vpn
  services.mullvad-vpn = {
    enable = true;
    enableExcludeWrapper = false;
  };

  networking.firewall.allowedTCPPorts = [ 11918 ];

  networking = {
    nat = {
      enable = true;
      internalInterfaces = [ "ve-+" ];
      externalInterface = "wg-mullvad";

      forwardPorts = [
        {
          destination = "192.168.100.11:80";
          sourcePort = 11918;
        }
      ];
    };
  };

  virtualisation.vmware.host = {
    enable = true;
    extraConfig = /* config */ ''
      # Enable 3D acceleration on the host
      mks.gl.allowUnsupportedDrivers = "TRUE"
      mks.vk.allowUnsupportedDevices = "TRUE"
    '';
  };

  programs.htop = {
    enable = true;
    package = pkgs."htop-vim";
    settings = { tree_view = 1; };
  };

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
        user = VARIABLES.username;
      };
    };
  };

  zramSwap.enable = true; # Swap
}
