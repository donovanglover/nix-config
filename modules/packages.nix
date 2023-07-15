{ pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    grimblast
    slade
    typespeed
    osu-lazer-bin
    (pass.withExtensions (ext: with ext; [ pass-otp ]))
    pass
    treefmt
    jamesdsp
    zbar

    logseq
    mullvad-browser
    spek

    gdu
    fdupes
    mediainfo
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
    nixpkgs-review
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
    diskonaut

    zola
    file
    tessen
    wtype
    mtr
    cointop
    pqiv

    poppler_utils
    wl-clipboard
    lnch
    wev
    python311Packages.icoextract
    swww
    srb2
    crystalline
    go-thumbnailer
    pipe-rename
    cmus
    ironbar
    wallust
    activate-linux-wayland
    hyprland-relative-workspace
    eww-wayland
    tango
  ];

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "osu-lazer-bin"
  ];

  environment.defaultPackages = [ ];
}
