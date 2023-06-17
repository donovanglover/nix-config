{ pkgs, ... }:

{
  programs.hyprland.enable = true;

  i18n.inputMethod.enabled = "fcitx5";
  i18n.inputMethod.fcitx5.addons = [ pkgs.fcitx5-mozc ];

  security.pam.services.swaylock = { };

  services.udisks2 = {
    enable = true;
    mountOnMedia = true;
  };

  environment.systemPackages = with pkgs; [
    polkit_gnome
  ];

  services.xserver = {
    enable = true;
    displayManager.lightdm.enable = false;
    excludePackages = [ pkgs.xterm ];
  };
}
