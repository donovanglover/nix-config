{ pkgs, ... }:

let VARIABLES = import ../src/variables.nix; in {
  services.greetd = {
    enable = true;
    restart = false;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland";
        user = "greeter";
      };
      initial_session = {
        command = "${pkgs.hyprland}/bin/Hyprland";
        user = VARIABLES.username;
      };
    };
  };
}
