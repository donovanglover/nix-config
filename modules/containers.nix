{ config, nix-config, lib, ... }:

let
  inherit (lib) mkIf;
  inherit (config.modules.system) username phone;
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
  systemd.tmpfiles.rules = [
    "d /run/user/1000 0700 ${username} users -"
  ];

  containers = mkIf (enableContainers && !phone) {
    wine = template // {
      hostAddress = "192.168.100.34";
      localAddress = "192.168.100.49";

      config = { ... }: {
        imports = [
          ../containers
          ../containers/wine.nix
        ];
      };
    };
  };
}
