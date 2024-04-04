{ pkgs, config, lib, ... }:

let
  inherit (lib) mkEnableOption mkIf;
  inherit (pkgs) piper;

  cfg = config.modules.hardware;
in
{
  options.modules.hardware = {
    mouseSettings = mkEnableOption "piper for gaming mice";
    disableLaptopKeyboard = mkEnableOption "udev rule to disable laptop keyboard";
    lidIgnore = mkEnableOption "ignoring the laptop lid on close";
    powerIgnore = mkEnableOption "ignoring the power button on press";
  };

  config = with cfg; {
    services = {
      ratbagd.enable = mkIf mouseSettings true;

      udev.extraRules = mkIf disableLaptopKeyboard ''
        KERNEL=="event*", ATTRS{name}=="AT Translated Set 2 keyboard", ENV{LIBINPUT_IGNORE_DEVICE}="1"
      '';

      logind = {
        lidSwitch = mkIf lidIgnore "ignore";
        extraConfig = mkIf powerIgnore "HandlePowerKey=ignore";
      };
    };

    environment.systemPackages = mkIf mouseSettings [ piper ];
  };
}
