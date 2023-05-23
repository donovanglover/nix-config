{ pkgs, ... }:

{
  imports = [
    ./bat
    ./fish
    ./git
    ./gpg
    ./htop
    ./ncmpcpp
    ./neovim
    ./ranger
    ./starship
    ./tig
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
  ];
}
