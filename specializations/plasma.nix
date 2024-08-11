{ lib, config, ... }:

let
  inherit (config.modules.system) username;
in
{
  services = {
    displayManager = {
      sddm.enable = true;

      autoLogin = {
        enable = true;
        user = username;
      };
    };

    desktopManager.plasma6.enable = true;

    greetd.enable = lib.mkForce false;
  };

  systemd.services = {
    "getty@tty1".enable = false;
    "autovt@tty1".enable = false;
  };

  programs.hyprland.enable = lib.mkForce false;
}
