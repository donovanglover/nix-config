{
  nixosConfig,
  config,
  pkgs,
  ...
}:

let
  inherit (nixosConfig._module.specialArgs) nix-config;

  phosh-backgrounds = nix-config.packages.${pkgs.system}.phosh-backgrounds.override {
    color = config.lib.stylix.colors.base00;
  };
in
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

  stylix.targets.gtk.extraCss = # css
    ''
      phosh-lockscreen {
        background: url('${phosh-backgrounds}/wall-lock.jpg');
      }

      phosh-app-grid {
        background: url('${phosh-backgrounds}/wall-grid.jpg');
      }

      phosh-top-panel {
        background: url('${phosh-backgrounds}/wall-panel.jpg');
      }

      phosh-home {
        background: url('${phosh-backgrounds}/wall-home.jpg');
      }

      phosh-lockscreen, phosh-app-grid, phosh-top-panel, phosh-home {
        background-size: cover;
        background-position: center;
      }
    '';
}
