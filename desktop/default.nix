{ pkgs, ... }:

{
  imports = [
    ./dual-function-keys
    ./dunst
    ./fcitx5
    ./fonts
    ./gtk
    ./hyprland
    ./mozc
    ./nwg-dock
    ./pipewire
    ./rofi
    ./stylix
    ./swaylock
    ./udiskie
    ./waybar
    ./xcursor
    ./xdg-user-dirs
    ./xresources
    ./xserver
  ];

  environment.systemPackages = with pkgs; [
    grim
    slurp
    wl-clipboard
    lnch
    wev
    swww
  ];
}
