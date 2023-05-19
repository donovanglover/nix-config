{ pkgs, ... }:

{
  imports = [
    ./feh
    ./kitty
    ./librewolf
    ./mpv
    ./piper
    ./qutebrowser
    ./thunar
    ./zathura
  ];

  environment.systemPackages = with pkgs; [
    audacity
    gimp
    anki
    logseq
    litemdview
    mullvad-browser
    spek
    keepassxc
  ];
}
