{ pkgs, lib, sakaya, ... }:

{
  environment.systemPackages = with pkgs; [
    grimblast
    slade
    osu-lazer-bin
    (pass.withExtensions (ext: with ext; [ pass-otp ]))
    pass
    treefmt
    jamesdsp
    zbar
    sakaya.packages.${system}.sakaya

    logseq
    mullvad-browser
    spek
    audacity
    gimp
    anki
    sqlitebrowser
    sqlcipher
    kanjidraw
    libreoffice
    inkscape
    krita
    aegisub
    element-desktop
    signal-desktop
    ungoogled-chromium
    qbittorrent

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
    nodePackages.prisma
    openssl

    zola
    file
    tessen
    wtype
    mtr
    cointop
    tectonic

    cargo-tauri

    pipe-rename
    poppler_utils
    wl-clipboard
    lnch
    wev
    dmenu-wayland
    python311Packages.icoextract
    swww
    srb2
    crystalline
    thud
    ironbar
    wallust
    activate-linux
    tango
    obs-studio
    nvd
    hyprdim
    nix-init
    diesel-cli
    litecli

    colorpanes
    sanctity
    didu

    timer
    tasktimer
    nix-search-cli
    satty
    aaaaxy
    lutgen
    sudachi-rs
    tui-journal
  ];

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "osu-lazer-bin-2024.130.2"
  ];

  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0"
  ];

  environment.defaultPackages = [ ];
}
