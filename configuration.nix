{ config, pkgs, lib, stylix, ... }:

{
  imports = [
    ./laptop.nix
    ./modules/starship.nix
    ./modules/fish.nix
    ./modules/fonts.nix
    ./modules/stylix
    ./modules/htop.nix
    ./modules/dual-function-keys.nix
    ./modules/tlp.nix
    ./modules/osu
    ./modules/srb2
    ./modules/mullvad
    ./modules/pipewire
    ./modules/networking
    ./modules/virtualization
    ./modules/xserver
    ./modules/systemd
    ./modules/vnstat
    ./modules/locale
    ./modules/firejail
    ./modules/timezone
    ./modules/nix
    ./modules/npm
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  environment.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    GIT_DISCOVERY_ACROSS_FILESYSTEM = "1";
    FZF_DEFAULT_OPTS = "--height 40% --reverse --border --color=16";
    NODE_OPTIONS = "--max_old_space_size=16384";
  };


  environment.systemPackages = with pkgs; [
    pinentry-curses
    wget
    grim
    slurp
    mullvad-browser
    papirus-icon-theme
    mediainfo
    pywal
    mpc-cli
    neofetch
    tectonic
    fdupes
    anki
    logseq
    yt-dlp
    gurk-rs
    wl-clipboard
    ffmpeg
    siege
    ponysay
    lolcat
    figlet
    httpie
    cmatrix
    sox
    spek
    p7zip
    ripgrep
    rsync
    jq
    keepassxc
    exa
    fd
    fzf
    unar
    audacity
    gimp
    typespeed
    slade
    gdu
    nixfmt
    whois
    lnch
    dwt1-shell-color-scripts
    dig
    trashy
    swaybg
    brightnessctl
    killall
    nodejs
    yarn
    deno
    crystal
    shards
    rustc
    rustfmt
    cargo
    genact
  ];

  environment.defaultPackages = [ ];

  system.stateVersion = "22.11";
}
