{
  config,
  lib,
  pkgs,
  ...
}:

{
  services = {
    xserver = {
      displayManager.startx.enable = true;

      windowManager.dwm = {
        enable = true;

        package = pkgs.callPackage ../packages/xland.nix (with config.lib.stylix.colors.withHashtag; {
          colorBackground = base00;
          colorText = base03;
          colorSelected = base05;
        });
      };
    };

    libinput = {
      touchpad = {
        naturalScrolling = true;
        accelProfile = "flat";
        accelSpeed = "0.75";
      };

      mouse = {
        accelProfile = "flat";
      };
    };

    greetd.settings = {
      default_session.command = lib.mkForce "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd startx --time-format '%F %R'";
      initial_session.command = lib.mkForce "${pkgs.xorg.xinit}/bin/startx";
    };
  };
}
