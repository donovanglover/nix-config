{ pkgs, lib, ... }:

{
  services.xserver = {
    enable = true;

    displayManager = {
      sddm.enable = true;

      autoLogin = {
        enable = true;
        user = "user";
      };
    };

    excludePackages = [ pkgs.xterm ];
  };

  services.desktopManager.plasma6.enable = true;

  systemd.services = {
    "getty@tty1".enable = false;
    "autovt@tty1".enable = false;
  };

  programs.hyprland.enable = lib.mkForce false;
  services.greetd.enable = lib.mkForce false;
}
