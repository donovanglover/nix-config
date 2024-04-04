{ pkgs, lib, config, ... }:

let
  inherit (lib) mkOption;
  inherit (lib.types) str listOf;
  inherit (pkgs.nixVersions) nix_2_19;
  inherit (cfg) username;

  cfg = config.modules.system;
in
{
  options.modules.system = {
    username = mkOption {
      type = str;
      default = "user";
    };

    timeZone = mkOption {
      type = str;
      default = "America/New_York";
    };

    defaultLocale = mkOption {
      type = str;
      default = "ja_JP.UTF-8";
    };

    supportedLocales = mkOption {
      type = listOf str;
      default = [ "ja_JP.UTF-8/UTF-8" "en_US.UTF-8/UTF-8" "fr_FR.UTF-8/UTF-8" ];
    };

    stateVersion = mkOption {
      type = str;
      default = "22.11";
    };
  };

  config = {
    boot = {
      tmp.cleanOnBoot = true;

      loader = {
        systemd-boot = {
          enable = true;
          editor = false;
          configurationLimit = 10;
        };

        timeout = 0;
        efi.canTouchEfiVariables = true;
      };
    };

    systemd = {
      extraConfig = "DefaultTimeoutStopSec=10s";
      services.NetworkManager-wait-online.enable = false;
    };

    nix = {
      package = nix_2_19;

      settings = {
        experimental-features = [ "nix-command" "flakes" "repl-flake" ];
        auto-optimise-store = true;
        warn-dirty = false;
      };
    };

    zramSwap = {
      enable = true;
      memoryPercent = 100;
    };

    time = {
      inherit (cfg) timeZone;
    };

    i18n = {
      inherit (cfg) defaultLocale supportedLocales;
    };

    system = {
      inherit (cfg) stateVersion;
    };

    users = {
      mutableUsers = false;

      users.${username} = {
        isNormalUser = true;
        uid = 1000;
        password = "user";
        extraGroups = [ "wheel" "networkmanager" ];
      };
    };

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;

      sharedModules = [{
        home.stateVersion = "22.11";
        programs.man.generateCaches = true;
      }];

      users.${username}.home = {
        inherit username;

        homeDirectory = "/home/${username}";
      };
    };
  };
}
