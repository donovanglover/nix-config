{ pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    grimblast
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
    unrar-wrapper
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
    gnome.gnome-disk-utility
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
    mdbook
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
    swww
    srb2
    crystalline
    go-thumbnailer
    pipe-rename
  ];

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "osu-lazer-bin"
  ];

  environment.defaultPackages = [ ];
}
