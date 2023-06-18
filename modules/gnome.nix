{ pkgs, lib, ... }:

{
  services.xserver = {
    enable = true;
    displayManager.lightdm.enable = false;
    excludePackages = [ pkgs.xterm ];
  };

  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.displayManager.gdm.enable = true;

  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "user";
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  i18n.inputMethod = lib.mkForce {
    enabled = "ibus";
    ibus.engines = with pkgs.ibus-engines; [ mozc ];
 };

  # services.gnome.core-utilities.enable = false;
  environment.gnome.excludePackages = [ pkgs.gnome-tour ];

  hardware.pulseaudio.enable = false;
  programs.hyprland.enable = lib.mkForce false;
  services.greetd.enable = lib.mkForce false;
}
