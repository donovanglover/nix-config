{ lib, config, ... }:

{
  home-manager.sharedModules = [
    ./dunst.nix
    ./fcitx.nix
    ./fish.nix
    ./git.nix
    ./gpg.nix
    ./gtk.nix
    ./htop.nix
    ./hyprland.nix
    ./ironbar.nix
    ./joshuto.nix
    ./kitty.nix
    ./librewolf.nix
    ./mime-apps.nix
    ./mpv.nix
    ./ncmpcpp.nix
    ./neovim.nix
    ./pqiv.nix
    ./qutebrowser.nix
    ./rofi.nix
    ./swaylock.nix
    ./thunar.nix
    (lib.mkIf (config.programs.hyprland.enable == true) ./udiskie.nix)
    ./xcursor.nix
    ./xdg-user-dirs.nix
    ./xresources.nix
    ./zathura.nix
  ];
}
