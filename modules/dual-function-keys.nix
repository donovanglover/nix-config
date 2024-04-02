{ pkgs, lib, ... }:

let
  inherit (lib) getExe;
  inherit (builtins) toJSON;
  inherit (pkgs) interception-tools;
  inherit (pkgs.interception-tools-plugins) dual-function-keys;

  configFile = "dual-function-keys.yaml";
in
{
  services.interception-tools = {
    enable = true;
    plugins = [ dual-function-keys ];

    udevmonConfig = toJSON [
      {
        JOB = /* bash */ ''
          ${interception-tools}/bin/intercept -g $DEVNODE |
          ${getExe dual-function-keys} -c /etc/${configFile} |
          ${interception-tools}/bin/uinput -d $DEVNODE
        '';

        DEVICE = {
          EVENTS = {
            EV_KEY = [ "KEY_CAPSLOCK" "KEY_ESC" ];
          };
        };
      }
    ];
  };

  environment.etc.${configFile}.text = toJSON {
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
        TAP = [ "KEY_LEFTMETA" "KEY_F1" ];
        HOLD = "KEY_LEFTMETA";
      }
      {
        KEY = "KEY_RIGHTSHIFT";
        TAP = [ "KEY_LEFTMETA" "KEY_F2" ];
        HOLD = "KEY_RIGHTSHIFT";
      }
      {
        KEY = "KEY_RIGHTALT";
        TAP = "KEY_GRAVE";
        HOLD = "KEY_RIGHTALT";
      }
    ];
  };
}
