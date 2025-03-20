{
  nix-config,
  pkgs,
  lib,
  config,
  ...
}:

let
  inherit (lib.types) nullOr str listOf;
  inherit (config.boot) isContainer;

  inherit (lib)
    mkOption
    mkEnableOption
    mkIf
    singleton
    optional
    ;

  inherit (cfg)
    username
    iHaveLotsOfRam
    hashedPassword
    mullvad
    allowSRB2Port
    allowDevPort
    ;

  cfg = config.modules.system;
in
{
  imports = with nix-config.inputs.home-manager.nixosModules; [ home-manager ];

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

      default = [
        "ja_JP.UTF-8/UTF-8"
        "en_US.UTF-8/UTF-8"
        "fr_FR.UTF-8/UTF-8"
      ];
    };

    stateVersion = mkOption {
      type = str;
      default = "22.11";
    };

    hostName = mkOption {
      type = str;
      default = "nixos";
    };

    iHaveLotsOfRam = mkEnableOption "tmpfs on /tmp";
    mullvad = mkEnableOption "mullvad vpn";
    allowSRB2Port = mkEnableOption "port for srb2";
    allowDevPort = mkEnableOption "port for development server";
  };

  config = {
    boot = {
      tmp = if iHaveLotsOfRam then { useTmpfs = true; } else { cleanOnBoot = true; };

      binfmt.emulatedSystems = mkIf (pkgs.system == "x86_64-linux") [ "aarch64-linux" ];

      loader = {
        systemd-boot = mkIf (pkgs.system != "aarch64-linux") {
          enable = true;
          editor = false;
          configurationLimit = 10;
        };

        timeout = 0;
        efi.canTouchEfiVariables = true;
      };

      blacklistedKernelModules = [ "floppy" ];
    };

    systemd = {
      extraConfig = "DefaultTimeoutStopSec=10s";
      services.NetworkManager-wait-online.enable = false;
    };

    nix = {
      settings = {
        auto-optimise-store = true;
        warn-dirty = false;
        allow-import-from-derivation = false;
        keep-going = true;

        experimental-features = [
          "nix-command"
          "flakes"
        ];

        trusted-users = [
          "root"
          "@wheel"
        ];
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
      allowNoPasswordLogin = mkIf isContainer true;

      users.${username} = {
        inherit hashedPassword;

        isNormalUser = true;
        uid = 1000;
        password = mkIf (hashedPassword == null && !isContainer) username;

        extraGroups =
          if isContainer then
            [ ]
          else
            [
              "wheel"
              "networkmanager"
              "dialout"
              "feedbackd"
              "video"
              "input"
            ];
      };
    };

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;

      sharedModules = singleton {
        home = {
          inherit (cfg) stateVersion;
        };

        programs.man.generateCaches = true;
      };

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
        externalInterface = "wg0-mullvad";
      };

      firewall = {
        allowedUDPPorts = [
          67
          68
        ] ++ optional allowSRB2Port [ 5029 ];

        allowedTCPPorts = [
          80
          443
        ] ++ optional allowDevPort [ 3000 ];
      };
    };

    services = {
      resolved.llmnr = "false";

      mullvad-vpn = mkIf mullvad {
        enable = true;
        enableExcludeWrapper = false;
      };

      openssh = {
        enable = true;

        settings = {
          PasswordAuthentication = false;
          KbdInteractiveAuthentication = false;
        };
      };

      udev.extraRules = ''
        KERNEL=="uinput", GROUP="input", MODE="0660", OPTIONS+="static_node=uinput"
      '';
    };

    environment = {
      systemPackages = with pkgs; [ (pass.withExtensions (ext: with ext; [ pass-otp ])) ];
      gnome.excludePackages = with pkgs; [ gnome-tour ];
    };

    programs.command-not-found.enable = false;
  };
}
