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
    aegisub
    element-desktop
    signal-desktop
    ungoogled-chromium

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
    yazi

    zola
    file
    tessen
    wtype
    mtr
    cointop
    tectonic

    cargo-tauri

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
    activate-linux
    tango
    obs-studio
    nvd
    broot
    hyprdim
    nix-init
    leetcode-cli
    diesel-cli
    litecli

    colorpanes
    sanctity
    didu

    timer
    tasktimer
  ];

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "osu-lazer-bin-2023.1008.1"
  ];

  environment.defaultPackages = [ ];
}
