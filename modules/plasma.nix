{ pkgs, lib, ... }:

{
  services.xserver = {
    enable = true;

    desktopManager = {
      plasma5.enable = true;
    };

    displayManager = {
      sddm.enable = true;

      autoLogin = {
        enable = true;
        user = "user";
      };
    };

    excludePackages = [ pkgs.xterm ];
  };

  systemd.services = {
    "getty@tty1".enable = false;
    "autovt@tty1".enable = false;
  };

  programs.hyprland.enable = lib.mkForce false;
  services.greetd.enable = lib.mkForce false;
}
