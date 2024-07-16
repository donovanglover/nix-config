{ config, lib, ... }:

let
  inherit (lib) mkForce;
  inherit (config.modules.system) username;
  inherit (builtins) attrValues;

  transparency = "0.7";
  getColorCh = colorName: channel: config.lib.stylix.colors."${colorName}-rgb-${channel}";
  rgba = color: ''rgba(${getColorCh color "r"}, ${getColorCh color "g"}, ${getColorCh color "b"}, ${transparency})'';
in
{
  programs.hyprland.enable = mkForce false;
  i18n.inputMethod.enable = mkForce false;
  services.greetd.enable = mkForce false;

  xserver = {
    displayManager.lightdm.enable = false;

    desktopManager.phosh = {
      enable = true;
      group = "users";
      user = username;

      phocConfig = {
        xwayland = "immediate";
      };
    };
  };

  home-manager.sharedModules = attrValues {
    background = {
      stylix.targets.gtk.extraCss = /* css */ ''
        phosh-lockscreen, .phosh-lockshield {
          background-image: linear-gradient(${rgba "base00"}, ${rgba "base00"}), url('file:///home/${username}/wall-lock.jpg');
          background-size: cover;
          background-position: center;
        }

        phosh-app-grid {
          background-image: linear-gradient(${rgba "base00"}, ${rgba "base00"}), url('file:///home/${username}/wall-grid.jpg');
          background-size: cover;
          background-position: center;
        }

        phosh-top-panel {
          background-image: linear-gradient(${rgba "base00"}, ${rgba "base00"}), url('file:///home/${username}/wall-panel.jpg');
          background-size: cover;
          background-position: center;
        }

        phosh-home {
          background-image: linear-gradient(${rgba "base00"}, ${rgba "base00"}), url('file:///home/${username}/wall-home.jpg');
          background-size: cover;
          background-position: center;
        }
      '';
    };
  };
}
