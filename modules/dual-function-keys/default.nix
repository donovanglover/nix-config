{ pkgs, ... }:

{
  services.interception-tools = {
    enable = true;
    plugins = [ pkgs.interception-tools-plugins.dual-function-keys ];
    udevmonConfig = ''
      - JOB: "${pkgs.interception-tools}/bin/intercept -g $DEVNODE | ${pkgs.interception-tools-plugins.dual-function-keys}/bin/dual-function-keys -c /etc/dual-function-keys.yaml | ${pkgs.interception-tools}/bin/uinput -d $DEVNODE"
        DEVICE:
          EVENTS:
            EV_KEY: [KEY_CAPSLOCK, KEY_ESC]
    '';
  };

  environment.etc."dual-function-keys.yaml".text = ''
    TIMING:
        - TAP_MILLISEC: 1000
        - DOUBLE_TAP_MILLISEC: 0
        - SYNTHETIC_KEYS_PAUSE_MILLISEC: 0
    MAPPINGS:
        - KEY: KEY_CAPSLOCK
          TAP: KEY_ESC
          HOLD: KEY_LEFTCTRL
        - KEY: KEY_SYSRQ
          TAP: KEY_SYSRQ
          HOLD: KEY_RIGHTMETA
        - KEY: KEY_RIGHTSHIFT
          TAP: [ KEY_LEFTMETA, KEY_F2 ]
          HOLD: KEY_RIGHTSHIFT
  '';
}
