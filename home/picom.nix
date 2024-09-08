{ lib, ... }:

{
  services.picom = rec {
    enable = true;
    backend = "glx";

    vSync = true;
    fade = true;
    shadow = true;

    fadeDelta = 5;
    shadowOpacity = 0.2;

    fadeExclude = [
      "window_type = 'menu'"
      "window_type = 'dropdown_menu'"
      "window_type = 'popup_menu'"
      "window_type = 'tooltip'"
    ];

    shadowExclude = fadeExclude ++ [
      "class_g = 'slop'"
    ];

    opacityRules = [
      "95:class_g = 'Thunar'"
    ];

    settings = {
      blur = {
        method = "dual_kawase";
        size = 10;
      };

      blur-background-exclude = [
        "class_g = 'slop'"
      ];

      clip-shadow-above = [
        "class_g = 'dwm'"
      ];
    };
  };

  systemd.user.services.picom = lib.mkForce { };
}
