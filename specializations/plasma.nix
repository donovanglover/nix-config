{ pkgs, lib, config, ... }:

let
  inherit (config.modules.system) username;
  inherit (pkgs) xterm;
in
{
  services = {
    xserver = {
      enable = true;
      excludePackages = [ xterm ];
    };

    displayManager = {
      sddm.enable = true;

      autoLogin = {
        enable = true;
        user = username;
      };
    };
  };

  services.desktopManager.plasma6.enable = true;

  systemd.services = {
    "getty@tty1".enable = false;
    "autovt@tty1".enable = false;
  };

  programs.hyprland.enable = lib.mkForce false;
  services.greetd.enable = lib.mkForce false;
}
