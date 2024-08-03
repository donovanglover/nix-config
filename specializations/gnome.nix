{
  pkgs,
  lib,
  config,
  ...
}:

let
  inherit (config.modules.system) username;
in
{
  services = {
    xserver = {
      enable = true;

      desktopManager.gnome.enable = true;
      displayManager.gdm.enable = true;

      excludePackages = [ pkgs.xterm ];
    };

    displayManager.autoLogin = {
      enable = true;
      user = username;
    };
  };

  systemd.services = {
    "getty@tty1".enable = false;
    "autovt@tty1".enable = false;
  };

  i18n.inputMethod = lib.mkForce {
    type = "ibus";
    ibus.engines = with pkgs.ibus-engines; [ mozc ];
  };

  hardware.pulseaudio.enable = false;
  programs.hyprland.enable = lib.mkForce false;
  services.greetd.enable = lib.mkForce false;
}
