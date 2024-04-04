{ pkgs, sakaya, ... }:

{
  environment.systemPackages = with pkgs; [
    grimblast
    osu-lazer-bin
    (pass.withExtensions (ext: with ext; [ pass-otp ]))
    pass
    treefmt
    jamesdsp
    zbar
    sakaya.packages.${system}.sakaya

    sqlcipher

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

    pipe-rename
    poppler_utils
    wl-clipboard-rs
    lnch
    wev
    dmenu-wayland
    python311Packages.icoextract
    swww
    srb2
    crystalline
    thud
    wallust
    activate-linux
    tango
    obs-studio
    nvd
    hyprdim
    nix-init
    diesel-cli
    litecli
    lychee

    colorpanes
    sanctity
    didu

    nix-search-cli
    satty
    aaaaxy
    lutgen
    sudachi-rs
    pnpm-shell-completion
    rclone
  ];

  nixpkgs.config.allowUnfree = true;

  environment.defaultPackages = [ ];
}
