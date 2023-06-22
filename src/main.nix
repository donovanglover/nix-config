{ pkgs
, lib
, nix-gaming
, ...
}:

let VARIABLES = import ./variables.nix; in {
  environment.systemPackages = with pkgs; [
    grimblast
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

    poppler_utils
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
    ];

  environment.defaultPackages = [ ];
  system.stateVersion = VARIABLES.stateVersion;
}
