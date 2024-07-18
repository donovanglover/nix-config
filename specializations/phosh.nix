{ config, lib, ... }:

let
  inherit (lib) mkForce;
  inherit (config.modules.system) username;
  inherit (builtins) attrValues;

  getColorCh = colorName: channel: config.lib.stylix.colors."${colorName}-rgb-${channel}";
  rgba = color: transparency: ''rgba(${getColorCh color "r"}, ${getColorCh color "g"}, ${getColorCh color "b"}, ${transparency})'';
  bg = ''linear-gradient(${rgba "base00" "0.7"}, ${rgba "base00" "0.7"})'';
in
{
  programs.hyprland.enable = mkForce false;
  i18n.inputMethod.enable = mkForce false;
  services.greetd.enable = mkForce false;

  services.xserver = {
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
        phosh-lockscreen {
          background: ${bg}, url('file:///home/${username}/wall-lock.jpg');
        }

        phosh-app-grid {
          background: ${bg}, url('file:///home/${username}/wall-grid.jpg');
        }

        phosh-top-panel {
          background: ${bg}, url('file:///home/${username}/wall-panel.jpg');
        }

        phosh-home {
          background: ${bg}, url('file:///home/${username}/wall-home.jpg');
        }

        phosh-lockscreen, phosh-app-grid, phosh-top-panel, phosh-home {
          background-size: cover;
          background-position: center;
        }
      '';
    };
  };
}
