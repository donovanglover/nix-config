{ pkgs, ... }:

let
  username = "user";
in
{
  environment = {
    sessionVariables = {
      LIBGL_ALWAYS_SOFTWARE = "true";
    };

    shells = with pkgs; [
      fish
    ];

    systemPackages = with pkgs; [
      flare-signal
      gurk-rs
      anki
      android-tools
      wget
      chatty
      gnome-console
      megapixels
      kitty
      neovim
      fish
      yazi
      bat
      w3m
      librewolf
      git
      htop-vim
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
  };

  programs = {
    fish.enable = true;
    neovim.enable = true;
    calls.enable = true;
  };

  networking = {
    hostName = "mobile-nixos";
    wireless.enable = false;
    wireguard.enable = true;
    networkmanager.enable = true;
  };

  hardware = {
    pulseaudio = {
      enable = true;
      package = pkgs.pulseaudioFull;
    };

    bluetooth.enable = true;
    sensor.iio.enable = true;
  };

  services = {
    openssh.enable = true;

    xserver.desktopManager.phosh = {
      enable = true;
      group = "users";
      user = username;
    };
  };

  users = {
    defaultUserShell = pkgs.fish;

    users.${username} = {
      isNormalUser = true;
      description = username;
      password = username;

      extraGroups = [
        "dialout"
        "feedbackd"
        "networkmanager"
        "video"
        "wheel"
      ];
    };
  };

  powerManagement.enable = true;
  zramSwap.enable = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" "repl-flake" ];
  system.stateVersion = "23.11";
}
