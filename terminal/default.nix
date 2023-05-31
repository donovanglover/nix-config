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
