{ pkgs, ... }:

{
  home.packages = with pkgs; [ waycorner ];

  xdg.configFile."waycorner/config.toml".text = /* toml */ ''
    [waybar]
    enter_command = [ "waybar" ]
    exit_command = [ "killall", ".waybar-wrapped" ]
    locations = ["right"]  # default
    size = 40
    timeout_ms = 250
  '';
}
