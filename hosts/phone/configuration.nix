{ self, pkgs, config, lib, ... }:

let
  inherit (lib) mkIf mkForce;
  inherit (lib.gvariant) mkTuple mkUint32;
  inherit (config.modules.system) username;
  inherit (builtins) attrValues;

  getColorCh = colorName: channel: config.lib.stylix.colors."${colorName}-rgb-${channel}";
  rgba = color: transparency: ''rgba(${getColorCh color "r"}, ${getColorCh color "g"}, ${getColorCh color "b"}, ${transparency})'';
  bg = ''linear-gradient(${rgba "base00" "0.7"}, ${rgba "base00" "0.7"})'';
in
{
  imports = attrValues self.nixosModules;

  nixpkgs.overlays = attrValues {
    inherit (self.overlays)
      phinger-cursors
      ;
  };

  home-manager.sharedModules = attrValues {
    inherit (self.homeModules)
      alacritty
      eza
      fish
      git
      gpg
      gtk
      htop
      librewolf
      neovim
      starship
      xdg-user-dirs
      xresources
      ;

    config = {
      programs.man.generateCaches = mkForce false;

      dconf.settings = {
        "sm/puri/phosh" = {
          app-filter-mode = [ ];
          enable-suspend = true;
        };

        "sm/puri/phosh/lockscreen" = {
          shuffle-keypad = true;
        };

        "sm/puri/phosh/plugins" = {
          quick-settings = [
            "night-light-quick-setting"
            "caffeine-quick-setting"
          ];
        };

        "org/gnome/desktop/interface" = {
          show-battery-percentage = true;
        };

        "org/gnome/desktop/session" = {
          idle-delay = mkUint32 60;
        };

        "org/gnome/desktop/input-sources" = {
          sources = [
            (mkTuple [ "xkb" "us" ])
            (mkTuple [ "xkb" "jp+kana" ])
          ];
        };

        "org/gnome/eog/ui" = {
          image-gallery = true;
          sidebar = false;
        };

        "org/gnome/settings-daemon/plugins/power" = {
          sleep-inactive-ac-type = "nothing";
          sleep-inactive-battery-type = "suspend";
        };
      };
    };

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

  environment.systemPackages = attrValues {
    inherit (self.packages.${pkgs.system})
      webp-thumbnailer
      pinephone-toolkit
      ;

    inherit (pkgs.gnome)
      gnome-contacts
      gnome-sound-recorder
      gnome-maps
      ;

    inherit (pkgs)
      chatty
      megapixels
      fractal
      g4music
      livi
      gnome-calendar
      tuba
      eog
      ;
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

    firewall.checkReversePath = mkForce false;
  };

  services = {
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

    openssh.enable = true;

    udisks2.enable = mkForce false;
    pipewire.enable = mkForce false;
    greetd.enable = mkForce false;
  };

  boot = {
    enableContainers = false;

    binfmt.emulatedSystems = mkForce [ ];
    loader.systemd-boot.enable = mkIf (pkgs.system == "aarch64-linux") (mkForce false);
  };

  documentation.man.generateCaches = false;

  hardware.graphics.enable32Bit = mkForce false;
  virtualisation.libvirtd.enable = mkForce false;

  powerManagement = {
    enable = true;

    cpufreq = rec {
      min = 912000;
      max = min;
    };

    cpuFreqGovernor = "performance";
  };
}
