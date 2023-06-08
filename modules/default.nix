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
}
