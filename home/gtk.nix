{ pkgs, ... }:

let
  inherit (pkgs) phinger-cursors fluent-icon-theme;
in
{
  gtk = {
    enable = true;

    cursorTheme = {
      package = phinger-cursors;
      name = "phinger-cursors";
    };

    gtk3.extraConfig = {
      gtk-decoration-layout = "menu:";
      gtk-xft-antialias = 1;
      gtk-xft-hinting = 1;
      gtk-xft-hintstyle = "hintfull";
      gtk-xft-rgba = "rgb";
      gtk-recent-files-enabled = false;
    };

    iconTheme = {
      package = fluent-icon-theme;
      name = "Fluent-dark";
    };
  };
}
