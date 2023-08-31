{ pkgs, lib, sakaya, ... }:

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
    sakaya.packages.${pkgs.system}.sakaya

    logseq
    mullvad-browser
    spek
    audacity
    gimp
    anki
    sqlitebrowser
    kanjidraw
    libreoffice
    inkscape
    krita
    element-desktop
    signal-desktop

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
    # visidata
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
    # memento
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

    poppler_utils
    wl-clipboard
    lnch
    wev
    python311Packages.icoextract
    swww
    srb2
    crystalline
    thud
    pipe-rename
    ironbar
    wallust
    activate-linux-wayland
    tango
    obs-studio
    nvd
    broot
    hyprdim
    nix-init
  ];

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "osu-lazer-bin"
  ];

  environment.defaultPackages = [ ];
}
