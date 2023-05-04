{ config, pkgs, lib, ... }:

{
  imports = [./hardware-configuration.nix];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;
  environment.shells = with pkgs; [ fish ];

  time.timeZone = "America/New_York";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.supportedLocales = ["en_US.UTF-8/UTF-8" "ja_JP.UTF-8/UTF-8" "fr_FR.UTF-8/UTF-8"];

  services.xserver.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  programs.thunar.enable = true;

  nix.package = pkgs.nixFlakes;
  nix.settings.experimental-features = ["nix-command" "flakes"];
  environment.systemPackages = with pkgs; [
    neovim
    tmux
    fish
    wget
    librewolf
    kitty
    mullvad-vpn
    mullvad-browser
    papirus-icon-theme
    alacritty
    pywal
    mpv
    neofetch
    anki
    git
    hyprland
    htop
    logseq
    wl-clipboard
  ];

  fonts.enableDefaultFonts = true;
  fonts.fonts = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    hack-font
  ];

  fonts.fontconfig = {
    defaultFonts = {
      serif = ["Noto Serif CJK JP" "Noto Serif"];
      sansSerif = ["Noto Sans CJK JP" "Noto Sans"];
      monospace = ["Noto Mono CJK JP" "Noto Mono"];
    };
  };

  fonts.fontconfig.hinting.style = "hintfull";

  i18n.inputMethod = {
    enabled = "ibus";
    ibus.engines = with pkgs.ibus-engines; [ anthy mozc ];
  };

  services.gnome.core-utilities.enable = false;
  services.mullvad-vpn.enable = true;

  networking.networkmanager.wifi.macAddress = "random";
  networking.networkmanager.ethernet.macAddress = "random";
  services.resolved.llmnr = "false";

  system.stateVersion = "22.11";
}
