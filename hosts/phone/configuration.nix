{
  self,
  pkgs,
  config,
  lib,
  ...
}:

let
  inherit (lib) mkIf mkForce;
  inherit (config.modules.system) username;
  inherit (builtins) attrValues;
in
{
  imports = attrValues self.nixosModules;

  nixpkgs = {
    overlays = with self.overlays; [ phinger-cursors ];

    config.permittedInsecurePackages = [
      "olm-3.2.16"
    ];
  };

  home-manager.sharedModules = attrValues {
    inherit (self.homeModules)
      dconf
      eza
      fish
      git
      gpg
      gtk
      htop
      kitty
      librewolf
      neovim
      starship
      xdg-user-dirs
      xresources
      ;

    config = {
      programs.man.generateCaches = mkForce false;
    };
  };

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

  modules = {
    system = {
      hostName = "mobile-nixos";
      stateVersion = "23.11";
      mullvad = true;
    };

    hardware.keyboardBinds = true;
  };

  i18n.inputMethod.enable = mkForce false;

  programs = {
    calls.enable = true;

    cdemu.enable = mkForce false;
    hyprland.enable = mkForce false;
    thunar.enable = mkForce false;
  };

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

  services = {
    xserver = {
      displayManager.lightdm.enable = false;

      desktopManager.phosh = {
        enable = true;
        group = "users";
        user = username;
      };
    };

    udisks2.enable = mkForce false;
    pipewire.enable = mkForce false;
    greetd.enable = mkForce false;
  };

  boot = {
    enableContainers = false;

    binfmt.emulatedSystems = mkForce [ ];
    loader.systemd-boot.enable = mkIf (pkgs.system == "aarch64-linux") (mkForce false);

    kernel.sysctl = {
      "vm.dirty_background_ratio" = 5;
      "vm.dirty_ratio" = 10;
    };
  };

  documentation = {
    enable = false;
    man.generateCaches = false;
  };

  hardware.graphics.enable32Bit = mkForce false;

  powerManagement = {
    enable = true;

    cpufreq = rec {
      min = 816000;
      max = min;
    };

    cpuFreqGovernor = "performance";
  };
}
