{ lib, ... }:

let
  inherit (lib) singleton;
in
{
  home-manager.sharedModules = singleton {
    services.picom.enable = true;
    services.dunst.enable = true;
  };

  services = {
    xserver = {
      displayManager.startx.enable = true;
      windowManager.dwm.enable = true;
    };

    libinput = {
      touchpad = {
        naturalScrolling = true;
        accelProfile = "flat";
      };

      mouse = {
        accelProfile = "flat";
      };
    };
  };
}
