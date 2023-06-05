{ pkgs, ... }:

{
  imports = [
    ./fish-starship
    ./git
    ./gpg
    ./ncmpcpp
    ./neovim
    ./joshuto
  ];

  environment.systemPackages = with pkgs; [
    wget
    jq
    exa
    fd
    fzf
    gdu
    fdupes
    mediainfo
    ponysay
    lolcat
    cmatrix
    sox
    httpie
    p7zip
    ripgrep
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
    librespeed-cli
    wiki-tui
    hexyl
    nb
    jpegoptim
    playerctl
    recode
    rmlint
    sd
    crystal
    shards
    smartmontools
    sqlitebrowser
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
    wails
    watchexec
    memento
    mpvpaper
    timg
    kanjidraw
    ventoy
    wf-recorder
    mdcat
    mdbook
    zola
    file
    tessen
    wtype
    mtr
  ];

  home-manager.sharedModules = [{
    programs.bat.enable = true;
  }];

  programs.htop = {
    enable = true;
    package = pkgs."htop-vim";
    settings = { tree_view = 1; };
  };
}
