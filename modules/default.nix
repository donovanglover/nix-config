{pkgs, ...}: let
  VARIABLES = import ../src/variables.nix;
in {
  imports = [
    ./feh
    ./kitty
    ./librewolf
    ./mpv
    ./piper
    ./qutebrowser
    ./thunar
    ./zathura

    ./fish-starship
    ./git
    ./gpg
    ./ncmpcpp
    ./neovim
    ./joshuto

    ./dual-function-keys
    ./dunst
    ./fcitx5-mozc
    ./fonts
    ./hyprland
    ./pipewire
    ./rofi
    ./stylix
    ./swaylock
    ./waybar
    ./xdg-user-dirs
  ];

  virtualisation.vmware.host = {
    enable = true;
    extraConfig = ''
      # Enable 3D acceleration on the host
      mks.gl.allowUnsupportedDrivers = "TRUE"
      mks.vk.allowUnsupportedDevices = "TRUE"
    '';
  };

  environment.systemPackages = with pkgs; [
    audacity
    gimp
    anki
    logseq
    mullvad-browser
    spek
    keepassxc
    libreoffice

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

    grim
    slurp
    wl-clipboard
    lnch
    wev
    swww
    kickoff
    greetd.tuigreet
    (pkgs.callPackage ../packages/nwg-dock {})
    (pkgs.callPackage ../packages/hyprland-autorename-workspaces {})
  ];

  home-manager.sharedModules = [
    {
      programs.bat.enable = true;
    }
  ];

  programs.htop = {
    enable = true;
    package = pkgs."htop-vim";
    settings = {tree_view = 1;};
  };

  services.greetd = {
    enable = true;
    restart = false;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland";
        user = "greeter";
      };
      initial_session = {
        command = "${pkgs.hyprland}/bin/Hyprland";
        user = VARIABLES.username;
      };
    };
  };

  zramSwap.enable = true;
}
