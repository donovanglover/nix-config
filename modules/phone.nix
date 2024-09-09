{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (lib)
    mkIf
    mkEnableOption
    mkForce
    ;

  inherit (config.modules.system) username;

  cfg = config.modules.phone;
in
{
  options.modules.phone = {
    enable = mkEnableOption "phone support";
  };

  config = mkIf cfg.enable {
    environment = {
      sessionVariables = {
        LIBGL_ALWAYS_SOFTWARE = "true";
      };

      systemPackages = with pkgs; [
        chatty
        megapixels
        livi
        gnome-contacts
        eog
      ];
    };

    programs.calls.enable = true;

    networking = {
      wireless.enable = false;
      wireguard.enable = true;

      networkmanager.ensureProfiles.profiles = {
        mobile = {
          connection = {
            id = "4G";
            type = "gsm";
          };

          gsm.apn = "NXTGENPHONE";
          ipv4.method = "auto";

          ipv6 = {
            addr-gen-mode = "default";
            method = "auto";
          };
        };
      };

      firewall.checkReversePath = mkForce false;
    };

    documentation = {
      enable = false;
      man.generateCaches = false;
    };

    services = {
      xserver = {
        displayManager.lightdm.enable = false;

        desktopManager.phosh = {
          enable = true;
          group = "users";
          user = username;
        };
      };
    };

    boot = {
      enableContainers = false;

      kernel.sysctl = {
        "vm.dirty_background_ratio" = 5;
        "vm.dirty_ratio" = 10;
      };
    };

    powerManagement = {
      enable = true;

      cpufreq = rec {
        min = 816000;
        max = min;
      };

      cpuFreqGovernor = "performance";
    };
  };
}
