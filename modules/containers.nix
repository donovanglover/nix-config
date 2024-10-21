{
  config,
  nix-config,
  lib,
  pkgs,
  ...
}:

let
  inherit (lib) mkIf;
  inherit (config.modules.system) username;
  inherit (config.boot) enableContainers;

  template = {
    privateNetwork = true;
    ephemeral = true;
    restartIfChanged = false;

    bindMounts = {
      "/mnt" = {
        hostPath = "/home/${username}/containers/wine";
        isReadOnly = false;
      };

      waylandDisplay = rec {
        hostPath = "/run/user/1000";
        mountPoint = hostPath;
      };

      x11Display = rec {
        hostPath = "/tmp/.X11-unix";
        mountPoint = hostPath;
      };

      dri = rec {
        hostPath = "/dev/dri";
        mountPoint = hostPath;
      };
    };

    allowedDevices = [
      {
        modifier = "rw";
        node = "/dev/dri/renderD128";
      }
    ];

    specialArgs = {
      inherit nix-config;
    };
  };
in
{
  environment.systemPackages = mkIf (pkgs.system == "x86_64-linux") (
    with nix-config.inputs.sakaya.packages.${pkgs.system}; [ sakaya ]
  );

  containers = mkIf enableContainers {
    wine = template // {
      hostAddress = "192.168.100.34";
      localAddress = "192.168.100.49";
      config =
        {
          nix-config,
          config,
          lib,
          pkgs,
          ...
        }:

        let
          inherit (nix-config.inputs.sakaya.packages.${pkgs.system}) sakaya;
          inherit (config.modules.system) username;
          inherit (lib) getExe;

          sakayaPort = 39493;
        in
        {
          imports = with nix-config.nixosModules; [
            shell
            desktop
            system
            stylix
            fonts
          ];

          home-manager.sharedModules = with nix-config.homeModules; [
            fish
            git
            gtk
            kitty
            neovim
            xresources
            yazi
          ];

          nixpkgs.overlays = builtins.attrValues nix-config.overlays;

          environment = {
            systemPackages =
              (with pkgs; [
                wineWowPackages.waylandFull
                winetricks
              ])
              ++ [ sakaya ];

            variables = {
              TERM = "xterm-kitty";
            };

            sessionVariables = {
              WAYLAND_DISPLAY = "wayland-1";
              QT_QPA_PLATFORM = "wayland";
              QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
              SDL_VIDEODRIVER = "wayland";
              CLUTTER_BACKEND = "wayland";
              MOZ_ENABLE_WAYLAND = "1";
              XDG_RUNTIME_DIR = "/run/user/1000";
              DISPLAY = ":0";
              QT_IM_MODULE = "fcitx";
              XMODIFIERS = "@im=fcitx";
              SDL_IM_MODULE = "fcitx";
              GLFW_IM_MODULE = "ibus";
              LC_ALL = "ja_JP.UTF-8";
              TZ = "Asia/Tokyo";
            };
          };

          hardware.graphics.enable = true;

          networking.firewall.allowedTCPPorts = [ sakayaPort ];

          systemd.services.sakaya = {
            enable = true;
            description = "sakaya server";

            unitConfig = {
              Type = "simple";
            };

            path = with pkgs; [ su ];

            serviceConfig = {
              ExecStart = "/usr/bin/env su ${username} --command=${getExe sakaya}";
            };

            wantedBy = [ "multi-user.target" ];
          };
        };
    };

    wordpress = {
      privateNetwork = true;
      ephemeral = true;
      autoStart = true;

      hostAddress = "192.168.100.24";
      localAddress = "192.168.100.39";

      specialArgs = {
        inherit nix-config;
      };

      config =
        { nix-config, pkgs, ... }:
        {
          imports = with nix-config.nixosModules; [
            system
          ];

          users.defaultUserShell = pkgs.fish;

          programs = {
            fish.enable = true;
            neovim.enable = true;
          };

          environment = {
            systemPackages = with pkgs; [ kitty ];
            shells = with pkgs; [ fish ];

            variables = {
              TERM = "xterm-kitty";
            };
          };

          networking = {
            firewall.allowedTCPPorts = [ 80 ];
          };

          services.wordpress.sites.localhost = { };
        };
    };
  };
}
