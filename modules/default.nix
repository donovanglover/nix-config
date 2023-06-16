{
  imports = [
    ./dual-function-keys
    ./fcitx5-mozc
    ./fish-starship
    ./fonts
    ./hyprland
    ./joshuto
    ./librewolf
    ./neovim
    ./piper
    ./pipewire
    ./stylix
    ./swaylock
    ./thunar
    ./waycorner
    ./xdg-user-dirs
  ];

  home-manager.sharedModules = [
    ./dunst
    ./feh
    ./git
    ./gpg
    ./kitty
    ./mime-apps
    ./mpv
    ./ncmpcpp
    ./qutebrowser
    ./rofi
    ./waybar
    ./zathura
  ];
}
