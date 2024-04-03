{ pkgs, config, lib, ... }:

let
  inherit (lib) mkEnableOption;
  inherit (pkgs) piper;

  cfg = config.modules.hardware;
in
{
  options.modules.hardware = {
    enable = mkEnableOption "hardware-specific configuration";
    mouseSettings = mkEnableOption "piper for mouse settings";
    laptopKeyboard = mkEnableOption "laptop keyboard";
    lidIgnore = mkEnableOption "lid switch to standby";
    powerIgnore = mkEnableOption "ignoring the power key";
  };

  # TODO: lib.mkIf cfg.enable
  config = {
    services.ratbagd.enable = true;
    environment.systemPackages = [ piper ];

    services.udev.extraRules = ''
      KERNEL=="event*", ATTRS{name}=="AT Translated Set 2 keyboard", ENV{LIBINPUT_IGNORE_DEVICE}="1"
    '';

    services.logind = {
      lidSwitch = "ignore";
      extraConfig = "HandlePowerKey=ignore";
    };
  };
}
