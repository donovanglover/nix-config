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

    jpegoptim
    recode
    rmlint
    smartmontools
    restic
    watchexec
    ventoy
    nodePackages.prisma
    openssl

    zola
    tectonic

    pipe-rename
    poppler_utils
    crystalline
    tango
    nvd
    nix-init
    diesel-cli
    litecli
    lychee

    nix-search-cli
    lutgen
    sudachi-rs
    pnpm-shell-completion
  ];

  nixpkgs.config.allowUnfree = true;

  environment.defaultPackages = [ ];
}
