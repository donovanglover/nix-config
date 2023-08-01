{ pkgs, hyprland, ... }:

{
  services.greetd = {
    enable = true;
    restart = false;

    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland";
        user = "greeter";
      };

      initial_session = {
        command = "${hyprland.packages.${pkgs.system}.hyprland}/bin/Hyprland";
        user = "user";
      };
    };
  };
}
