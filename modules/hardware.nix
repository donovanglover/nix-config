{
  pkgs,
  config,
  lib,
  ...
}:

let
  inherit (builtins) toJSON;

  inherit (lib)
    mkEnableOption
    mkIf
    getExe
    singleton
    ;

  inherit (cfg)
    mouseSettings
    lidIgnore
    keyboardBinds
    bluetooth
    ;

  dualFunctionKeysConfig = "dual-function-keys.yaml";

  cfg = config.modules.hardware;
in
{
  options.modules.hardware = {
    keyboardBinds = mkEnableOption "caps lock as ctrl when held and esc when tapped";
    mouseSettings = mkEnableOption "piper for gaming mice";
    bluetooth = mkEnableOption "bluetooth support";
    lidIgnore = mkEnableOption "ignoring the laptop lid on close";
  };

  config = {
    hardware.bluetooth.enable = mkIf bluetooth true;

    services = {
      ratbagd.enable = mkIf mouseSettings true;
      blueman.enable = mkIf bluetooth true;

      logind = {
        lidSwitch = mkIf lidIgnore "ignore";
        extraConfig = "HandlePowerKey=suspend";
      };

      interception-tools = {
        enable = mkIf keyboardBinds true;

        plugins = with pkgs.interception-tools-plugins; [
          dual-function-keys
        ];

        udevmonConfig = toJSON (singleton {
          JOB = # bash
            ''
              ${pkgs.interception-tools}/bin/intercept -g $DEVNODE |
              ${getExe pkgs.interception-tools-plugins.dual-function-keys} -c /etc/${dualFunctionKeysConfig} |
              ${pkgs.interception-tools}/bin/uinput -d $DEVNODE
            '';

          DEVICE = {
            EVENTS = {
              EV_KEY = [
                "KEY_CAPSLOCK"
                "KEY_ESC"
              ];
            };
          };
        });
      };
    };

    environment = {
      systemPackages = mkIf mouseSettings (with pkgs; [
        piper
      ]);

      etc.${dualFunctionKeysConfig}.text = toJSON {
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
  };
}
