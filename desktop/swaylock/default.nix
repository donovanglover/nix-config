{ pkgs, ... }:

{
  security.pam.services.swaylock = { };

  home-manager.sharedModules = [{
    programs.swaylock = {
      package = pkgs."swaylock-effects";
      settings = {
        show-keyboard-layout = true;
        daemonize = true;
        effect-blur = "20x2";
        clock = true;
        indicator = true;
        font-size = 25;
        indicator-radius = 85;
        indicator-thickness = 16;
        screenshots = true;
        fade-in = 1;
      };
    };
  }];
}
