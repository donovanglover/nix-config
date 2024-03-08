{ pkgs, ... }:

{
  services.interception-tools = {
    enable = true;
    plugins = with pkgs.interception-tools-plugins; [ dual-function-keys ];

    udevmonConfig = with pkgs; /* yaml */ ''
      - JOB: "${interception-tools}/bin/intercept -g $DEVNODE | ${interception-tools-plugins.dual-function-keys}/bin/dual-function-keys -c /etc/dual-function-keys.yaml | ${interception-tools}/bin/uinput -d $DEVNODE"
        DEVICE:
          EVENTS:
            EV_KEY: [KEY_CAPSLOCK, KEY_ESC]
    '';
  };

  environment.etc."dual-function-keys.yaml".text = /* yaml */ ''
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
        - KEY: KEY_LEFTMETA
          TAP: [ KEY_LEFTMETA, KEY_F1 ]
          HOLD: KEY_LEFTMETA
        - KEY: KEY_RIGHTSHIFT
          TAP: [ KEY_LEFTMETA, KEY_F2 ]
          HOLD: KEY_RIGHTSHIFT
        - KEY: KEY_LEFTSHIFT
          TAP: KEY_GRAVE
          HOLD: KEY_LEFTSHIFT
  '';
}
