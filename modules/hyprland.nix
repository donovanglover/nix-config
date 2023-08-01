{ pkgs, hyprland, ... }:

{
  programs.hyprland = {
    enable = true;
    package = hyprland.packages.${pkgs.system}.hyprland;
  };

  i18n.inputMethod.enabled = "fcitx5";
  i18n.inputMethod.fcitx5.addons = [ pkgs.fcitx5-mozc ];

  security.pam.services.swaylock = { };

  services.udisks2 = {
    enable = true;
    mountOnMedia = true;
  };

  services.xserver = {
    enable = true;
    excludePackages = [ pkgs.xterm ];
  };
}
