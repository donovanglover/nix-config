{ pkgs, ... }:

{
  imports = [
    ./fish-starship
    ./git
    ./gpg
    ./ncmpcpp
    ./neovim
    ./ranger
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

  home-manager.sharedModules = [{
    programs.bat.enable = true;
  }];

  programs.htop = {
    enable = true;
    package = pkgs."htop-vim";
    settings = { tree_view = 1; };
  };
}
