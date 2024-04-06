{ nix-config, pkgs, lib, config, ... }:

let
  inherit (lib) mkOption mkEnableOption mkIf;
  inherit (lib.types) nullOr str listOf;
  inherit (pkgs.nixVersions) nix_2_19;
  inherit (cfg) username iHaveLotsOfRam hashedPassword mullvad allowSRB2Port allowZolaPort;
  inherit (builtins) attrValues;

  cfg = config.modules.system;
in
{
  imports = attrValues {
    inherit (nix-config.inputs.home-manager.nixosModules) home-manager;
  };

  options.modules.system = {
    username = mkOption {
      type = str;
      default = "user";
    };

    hashedPassword = mkOption {
      type = nullOr str;
      default = null;
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

    iHaveLotsOfRam = mkEnableOption "tmpfs on /tmp";

    hostName = mkOption {
      type = str;
      default = "nixos";
    };

    mullvad = mkEnableOption "mullvad vpn";

    allowSRB2Port = mkEnableOption "port for srb2";
    allowZolaPort = mkEnableOption "port for zola";
  };

  config = {
    boot = {
      tmp =
        if iHaveLotsOfRam
        then { useTmpfs = true; }
        else { cleanOnBoot = true; };

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
        inherit hashedPassword;

        isNormalUser = true;
        uid = 1000;
        password = mkIf (hashedPassword == null) username;
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

    virtualisation.vmVariant = {
      virtualisation = {
        memorySize = 4096;
        cores = 4;

        sharedDirectories = {
          tmp = {
            source = "/tmp";
            target = "/mnt";
          };
        };

        qemu.options = [
          "-device virtio-vga-gl"
          "-display sdl,gl=on,show-cursor=off"
          "-audio pa,model=hda"
          "-full-screen"
        ];
      };

      environment.sessionVariables = {
        WLR_NO_HARDWARE_CURSORS = "1";
      };

      services.interception-tools.enable = lib.mkForce false;
      networking.resolvconf.enable = lib.mkForce true;
      zramSwap.enable = lib.mkForce false;

      boot.enableContainers = false;
    };

    networking = {
      inherit (cfg) hostName;

      networkmanager = {
        enable = true;
        wifi.macAddress = "random";
        ethernet.macAddress = "random";

        unmanaged = [ "interface-name:ve-*" ];
      };

      useHostResolvConf = true;

      resolvconf.enable = mkIf mullvad false;

      nat = mkIf mullvad {
        enable = true;
        internalInterfaces = [ "ve-+" ];
        externalInterface = "wg-mullvad";
      };

      firewall = {
        allowedUDPPorts = mkIf allowSRB2Port [
          5029
        ];

        allowedTCPPorts = mkIf allowZolaPort [
          1111
        ];
      };
    };

    services.resolved.llmnr = "false";

    services.mullvad-vpn = mkIf mullvad {
      enable = true;
      enableExcludeWrapper = false;
    };
  };
}
