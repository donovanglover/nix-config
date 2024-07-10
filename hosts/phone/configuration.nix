{ self, pkgs, lib, config, ... }:

let
  inherit (builtins) attrValues;

  transparency = "0.7";
  getColorCh = colorName: channel: config.lib.stylix.colors."${colorName}-rgb-${channel}";
  rgba = color: ''rgba(${getColorCh color "r"}, ${getColorCh color "g"}, ${getColorCh color "b"}, ${transparency})'';
in
{
  imports = attrValues self.nixosModules;

  nixpkgs.overlays = attrValues {
    inherit (self.overlays) phinger-cursors;
  };

  home-manager.sharedModules = attrValues {
    inherit (self.homeManagerModules)
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

    background = {
      stylix.targets.gtk.extraCss = /* css */ ''
        phosh-lockscreen, .phosh-lockshield {
          background-image: linear-gradient(${rgba "base00"}, ${rgba "base00"}), url('file:///home/user/wall-lock.jpg');
          background-size: cover;
          background-position: center;
        }

        phosh-app-grid {
          background-image: linear-gradient(${rgba "base00"}, ${rgba "base00"}), url('file:///home/user/wall-grid.jpg');
          background-size: cover;
          background-position: center;
        }

        phosh-top-panel {
          background-image: linear-gradient(${rgba "base00"}, ${rgba "base00"}), url('file:///home/user/wall-panel.jpg');
          background-size: cover;
          background-position: center;
        }

        phosh-home {
          background-image: linear-gradient(${rgba "base00"}, ${rgba "base00"}), url('file:///home/user/wall-home.jpg');
          background-size: cover;
          background-position: center;
        }
      '';
    };
  };

  environment.systemPackages = attrValues {
    inherit (self.packages.${pkgs.system})
      webp-thumbnailer
      ;
  };

  modules = {
    system = {
      hostName = "mobile-nixos";
      stateVersion = "23.11";
      phone = true;
    };

    desktop = {
      phone = true;
      phosh = true;
    };

    hardware.keyboardBinds = true;

    system = {
      mullvad = true;
    };
  };

  programs = {
    calls.enable = true;
  };

  services.pipewire.enable = lib.mkForce false;

  networking = {
    wireless.enable = false;
    wireguard.enable = true;
  };

  services = {
    openssh.enable = true;
  };

  powerManagement = {
    enable = true;

    cpufreq = rec {
      min = 648000;
      max = min;
    };

    cpuFreqGovernor = "powersave";
  };
}
