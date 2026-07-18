{ pkgs, ... }:

{
  gtk = {
    enable = true;

    gtk3.extraConfig = {
      gtk-decoration-layout = "menu:";
      gtk-xft-antialias = 1;
      gtk-xft-hinting = 1;
      gtk-xft-hintstyle = "hintfull";
      gtk-xft-rgba = "rgb";
      gtk-recent-files-enabled = false;
    };

    iconTheme = {
      package = pkgs.fluent-icon-theme;
      name = "Fluent-dark";
    };
  };
}
