{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    chatty
    gnome-console
    megapixels
    neovim
    fish
    yazi
    bat
    w3m
    librewolf
    git
    htop
    gnupg
    mpv
    ncmpcpp
    pqiv
    qutebrowser
    starship
    eza
    fd
    fzf
    ripgrep
    yt-dlp
    neofetch
    genact
    zellij
    p7zip
    unar
  ];

  programs.fish.enable = true;
  programs.neovim.enable = true;
  users.defaultUserShell = pkgs.fish;
  environment.shells = [ pkgs.fish ];

  networking = {
    hostName = "mobile-nixos";
    wireless.enable = false;
    networkmanager.enable = true;
  };

  hardware = {
    pulseaudio = {
      enable = true;
      package = pkgs.pulseaudioFull;
    };

    bluetooth.enable = true;
  };

  powerManagement.enable = true;

  zramSwap.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" "repl-flake" ];

  services.xserver.desktopManager.phosh = {
    enable = true;
    group = "users";
    user = "user";
  };

  users.users."user" = {
    isNormalUser = true;
    description = "User";
    password = "user";
    extraGroups = [
      "dialout"
      "feedbackd"
      "networkmanager"
      "video"
      "wheel"
    ];
  };

  system.stateVersion = "23.11";

  programs.calls.enable = true;

  hardware.sensor.iio.enable = true;
}
