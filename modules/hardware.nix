{ pkgs, config, lib, ... }:

let
  inherit (lib) mkEnableOption mkIf getExe singleton;
  inherit (pkgs) piper interception-tools;
  inherit (pkgs.interception-tools-plugins) dual-function-keys;
  inherit (cfg) mouseSettings lidIgnore powerIgnore keyboardBinds bluetooth;
  inherit (builtins) toJSON;

  dualFunctionKeysConfig = "dual-function-keys.yaml";

  cfg = config.modules.hardware;
in
{
  options.modules.hardware = {
    keyboardBinds = mkEnableOption "caps lock as ctrl when held and esc when tapped";
    mouseSettings = mkEnableOption "piper for gaming mice";
    bluetooth = mkEnableOption "bluetooth support";
    lidIgnore = mkEnableOption "ignoring the laptop lid on close";
    powerIgnore = mkEnableOption "ignoring the power button on press";
  };

  config = {
    hardware.bluetooth.enable = mkIf bluetooth true;

    services = {
      ratbagd.enable = mkIf mouseSettings true;
      blueman.enable = mkIf bluetooth true;

      logind = {
        lidSwitch = mkIf lidIgnore "ignore";
        extraConfig = mkIf powerIgnore "HandlePowerKey=ignore";
      };

      interception-tools = {
        enable = mkIf keyboardBinds true;
        plugins = [ dual-function-keys ];

        udevmonConfig = toJSON (singleton {
          JOB = /* bash */ ''
            ${interception-tools}/bin/intercept -g $DEVNODE |
            ${getExe dual-function-keys} -c /etc/${dualFunctionKeysConfig} |
            ${interception-tools}/bin/uinput -d $DEVNODE
          '';

          DEVICE = {
            EVENTS = {
              EV_KEY = [ "KEY_CAPSLOCK" "KEY_ESC" ];
            };
          };
        });
      };
    };

    environment.systemPackages = mkIf mouseSettings [ piper ];

    environment.etc.${dualFunctionKeysConfig}.text = toJSON {
      TIMING = [
        { TAP_MILLISEC = 1000; }
        { DOUBLE_TAP_MILLISEC = 0; }
        { SYNTHETIC_KEYS_PAUSE_MILLISEC = 0; }
      ];

      MAPPINGS = [
        {
          KEY = "KEY_CAPSLOCK";
          TAP = "KEY_ESC";
          HOLD = "KEY_LEFTCTRL";
        }
      ];
    };
  };
}
