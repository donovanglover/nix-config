{ pkgs, lib, ... }:

{
  services.xserver = {
    enable = true;
    displayManager.lightdm.enable = false;
    excludePackages = [ pkgs.xterm ];
  };

  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "user";
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  programs.hyprland.enable = lib.mkForce false;
  services.greetd.enable = lib.mkForce false;
}
