{ pkgs, ... }:

{
  home.packages = with pkgs; [ waycorner ];

  xdg.configFile."waycorner/config.toml".text = /* toml */ ''
    [application_launcher]
    enter_command = [ "hyprctl", "dispatch", "workspace", "empty" ]
    exit_command = [ "${pkgs.lnch}/bin/lnch", "${pkgs.rofi}/bin/rofi", "-show", "drun" ]
    locations = ["top_right"]  # default
    size = 10
    timeout_ms = 250

    [show_desktop]
    enter_command = [ "hyprctl", "dispatch", "workspace", "empty" ]
    exit_command = [ "hyprctl", "dispatch", "workspace", "previous"]
    locations = ["bottom_right"]  # default
    size = 10
    timeout_ms = 250
  '';
}
