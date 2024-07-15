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
    keyboardBinds = mkEnableOption "start button for rofi, caps lock as escape, etc.";
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
        {
          KEY = "KEY_SYSRQ";
          TAP = "KEY_SYSRQ";
          HOLD = "KEY_RIGHTMETA";
        }
        {
          KEY = "KEY_LEFTMETA";
          TAP = "KEY_FAVORITES";
          HOLD = "KEY_LEFTMETA";
        }
        {
          KEY = "KEY_RIGHTSHIFT";
          TAP = "KEY_MESSENGER";
          HOLD = "KEY_RIGHTSHIFT";
        }
        {
          KEY = "KEY_RIGHTALT";
          TAP = "KEY_GRAVE";
          HOLD = "KEY_RIGHTALT";
        }
      ];
    };
  };
}
