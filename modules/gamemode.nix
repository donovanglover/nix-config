{ pkgs, ... }:

{
  programs.gamemode = {
    enable = true;

    settings = {
      general = {
        renice = 10;
        igpu_power_threshold = -1;
      };

      custom = {
        start = "${pkgs.libnotify}/bin/notify-send 'Note' 'gamemode started from host.'";
        end = "${pkgs.libnotify}/bin/notify-send 'Note' 'gamemode ended from host.'";
      };
    };
  };
}
