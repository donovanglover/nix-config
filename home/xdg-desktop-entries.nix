{ lib, nixosConfig, ... }:

let
  inherit (lib) mkIf;

  isPhone = nixosConfig.programs.calls.enable;

  no = {
    name = "";
    settings.Hidden = "true";
  };
in
{
  xdg.desktopEntries = mkIf isPhone {
    anki = no;
    htop = no;
    fish = no;
    nvim = no;
    yazi = no;
    qt5ct = no;
    qt6ct = no;
    gcdemu = no;
    nixos-manual = no;
    image-analyzer = no;
    kvantummanager = no;
    chromium-browser = no;

    "org.gnome.Extensions" = no;
    "org.pwmt.zathura" = no;
    "org.gnome.eog" = no;
    "org.gnome.Settings" = no;
    "org.sigxcpu.Livi" = no;
  };
}
