{
  self,
  pkgs,
  config,
  lib,
  ...
}:

let
  inherit (lib) mkIf mkForce;
  inherit (lib.gvariant) mkTuple mkUint32;
  inherit (config.modules.system) username;
  inherit (builtins) attrValues;
  inherit (self.packages.${pkgs.system}) phosh-backgrounds;

  getColorCh = colorName: channel: config.lib.stylix.colors."${colorName}-rgb-${channel}";

  rgba =
    color: transparency:
    ''rgba(${getColorCh color "r"}, ${getColorCh color "g"}, ${getColorCh color "b"}, ${transparency})'';

  bg = ''linear-gradient(${rgba "base00" "0.7"}, ${rgba "base00" "0.7"})'';

  no = {
    name = "";
    settings = {
      Hidden = "true";
    };
  };
in
{
  imports = attrValues self.nixosModules;

  nixpkgs.overlays = with self.overlays; [ phinger-cursors ];

  home-manager.sharedModules = attrValues {
    inherit (self.homeModules)
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
      programs = {
        fish.functions.video = # fish
          ''
            ${pkgs.v4l-utils}/bin/media-ctl -d1 --links '"gc2145 3-003c":0->1:0[0],"ov5640 3-004c":0->1:0[1]'
            ${pkgs.v4l-utils}/bin/media-ctl -d1 --set-v4l2 '"ov5640 3-004c":0[fmt:UYVY8_2X8/1280x720@1/30]'

            ffmpeg \
              -input_format yuv420p \
              -s 1280x720 \
              -f video4linux2 \
              -thread_queue_size 4096 \
              -i /dev/video1 \
              -f pulse \
              -thread_queue_size 256 \
              -i alsa_input.platform-sound.Voice_Call__DigitalMic__source \
              -c:a libopus \
              -c:v libx264 \
              -preset ultrafast \
              -qp 23 \
              "$(date '+%x（%a）%R').mp4"
          '';

        man.generateCaches = mkForce false;
      };

      xdg = {
        desktopEntries = {
          anki = no;
          htop = no;
          fish = no;
          nvim = no;
          yazi = no;
          qt5ct = no;
          qt6ct = no;
          gcdemu = no;
          nixos-manual = no;
          image-analyzer = no;
          kvantummanager = no;
          chromium-browser = no;

          "org.gnome.Extensions" = no;
          "org.pwmt.zathura" = no;
          "org.gnome.eog" = no;
          "org.gnome.Settings" = no;
          "org.sigxcpu.Livi" = no;
        };

        userDirs = {
          download = mkForce "/home/${username}";
          documents = mkForce "/home/${username}";
          music = mkForce "/home/${username}";
          pictures = mkForce "/home/${username}";
          videos = mkForce "/home/${username}";
        };
      };

      dconf.settings = {
        "sm/puri/phosh" = {
          app-filter-mode = [ ];
          enable-suspend = true;

          favorites = [
            "org.gnome.Calls.desktop"
            "sm.puri.Chatty.desktop"
            "org.gnome.Contacts.desktop"
            "org.gnome.Calendar.desktop"
          ];
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

        "org/postmarketos/megapixels" = {
          save-raw = false;
        };

        "org/gnome/desktop/session" = {
          idle-delay = mkUint32 60;
        };

        "org/gnome/desktop/input-sources" = {
          sources = [
            (mkTuple [
              "xkb"
              "us"
            ])

            (mkTuple [
              "xkb"
              "jp+kana"
            ])
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
      stylix.targets.gtk.extraCss = # css
        ''
          phosh-lockscreen {
            background: ${bg}, url('${phosh-backgrounds}/wall-lock.jpg');
          }

          phosh-app-grid {
            background: ${bg}, url('${phosh-backgrounds}/wall-grid.jpg');
          }

          phosh-top-panel {
            background: ${bg}, url('${phosh-backgrounds}/wall-panel.jpg');
          }

          phosh-home {
            background: ${bg}, url('${phosh-backgrounds}/wall-home.jpg');
          }

          phosh-lockscreen, phosh-app-grid, phosh-top-panel, phosh-home {
            background-size: cover;
            background-position: center;
          }
        '';
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

  nixpkgs.config.permittedInsecurePackages = [
    "olm-3.2.16"
  ];

  modules = {
    system = {
      hostName = "mobile-nixos";
      stateVersion = "23.11";
      mullvad = true;
      phone = true;
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
