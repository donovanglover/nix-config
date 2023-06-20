{ pkgs
, lib
, hypr-contrib
, nix-gaming
, ...
}:

let VARIABLES = import ./variables.nix; in {
  imports = [
    "${VARIABLES.hostHardwareConfiguration}"
    ../overlays
    ../modules
    ../home
    ../containers
  ];

  # locale
  i18n.defaultLocale = VARIABLES.defaultLocale;
  i18n.supportedLocales = VARIABLES.supportedLocales;

  hardware.opengl.driSupport32Bit = true;

  environment.systemPackages = with pkgs; [
    hypr-contrib.packages."${VARIABLES.system}".grimblast
    nix-gaming.packages."${VARIABLES.system}".osu-stable
    waycorner
    slade
    typespeed
    osu-lazer-bin
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
    hexyl
    nb
    jpegoptim
    playerctl
    recode
    rmlint
    sd
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

    wl-clipboard
    lnch
    wev
    swww
    kickoff
    greetd.tuigreet
    hyprland-autoname-workspaces
    srb2
    crystalline
    go-thumbnailer
  ];

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "osu-lazer-bin"
      "vmware-workstation"
    ];

  environment.sessionVariables = {
    GIT_DISCOVERY_ACROSS_FILESYSTEM = "1";
    FZF_DEFAULT_OPTS = "--height 40% --reverse --border --color=16";
    NODE_OPTIONS = "--max_old_space_size=16384";
  };

  environment.defaultPackages = [ ];
  system.stateVersion = VARIABLES.stateVersion;

  time.timeZone = "${VARIABLES.timezone}"; # Timezone

  networking.firewall.allowedTCPPorts = [ 11918 ];
}
