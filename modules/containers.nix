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
    autoStart = true;
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
  systemd.tmpfiles.rules = [ "d /run/user/1000 0700 ${username} users -" ];

  environment.systemPackages = mkIf (pkgs.system == "x86_64-linux") (
    with nix-config.inputs.sakaya.packages.${pkgs.system}; [ sakaya ]
  );

  containers = mkIf enableContainers {
    wine = template // {
      hostAddress = "192.168.100.34";
      localAddress = "192.168.100.49";

      config =
        { ... }:
        {
          imports = [
            ../containers/wine.nix
          ];
        };
    };
  };
}
