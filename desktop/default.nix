{ pkgs, ... }:

{
  imports = [
    ./dual-function-keys
    ./dunst
    ./fcitx5-mozc
    ./fonts
    ./hyprland
    ./nwg-dock
    ./pipewire
    ./rofi
    ./stylix
    ./swaylock
    ./waybar
    ./xdg-user-dirs
  ];

  environment.systemPackages = with pkgs; [
    grim
    slurp
    wl-clipboard
    lnch
    wev
    swww
    kickoff
    greetd.tuigreet
  ];

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
        user = "user";
      };
    };
  };

  zramSwap.enable = true;
}
