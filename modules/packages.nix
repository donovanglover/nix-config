{ pkgs, sakaya, ... }:

{
  environment.systemPackages = with pkgs; [
    osu-lazer-bin
    (pass.withExtensions (ext: with ext; [ pass-otp ]))
    pass
    jamesdsp
    zbar
    sakaya.packages.${system}.sakaya

    sqlcipher

    fdupes
    mediainfo
    sox
    httpie
    ffmpeg
    killall
    trashy
    whois

    dig
    yt-dlp
    brightnessctl
    jpegoptim
    playerctl
    recode
    rmlint
    sd
    smartmontools
    hwinfo
    stress
    nixpkgs-review
    choose
    hdparm
    imagemagick
    restic
    watchexec
    mpvpaper
    timg
    ventoy
    wf-recorder
    diskonaut
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
    srb2
    crystalline
    thud
    wallust
    activate-linux
    tango
    nvd
    nix-init
    diesel-cli
    litecli
    lychee

    nix-search-cli
    satty
    aaaaxy
    lutgen
    sudachi-rs
    pnpm-shell-completion
  ];

  nixpkgs.config.allowUnfree = true;

  environment.defaultPackages = [ ];
}
