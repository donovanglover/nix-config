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
      config =
        { nix-config, pkgs, ... }:
        {
          imports =
            with nix-config.nixosModules;
            [
              shell
              desktop
              system
              stylix
              fonts
            ]
            ++ (with nix-config.inputs.sakaya.nixosModules; [ sakaya ]);

          sakaya.enable = true;

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
            systemPackages = with pkgs; [
              wineWowPackages.waylandFull
              winetricks
            ];

            variables.TERM = "xterm-kitty";
          };

          hardware.graphics.enable = true;
        };
    };
  };
}
