{ home-manager, stylix, ... }:

{
  containers.srb2 = {
    privateNetwork = true;
    ephemeral = true;
    hostAddress = "192.168.100.10";
    localAddress = "192.168.100.11";

    bindMounts = {
      "/home/user/.srb2" = {
        hostPath = "/home/user/containers/srb2";
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

    config = { pkgs, ... }: {
      imports = [
        home-manager.nixosModules.home-manager
        stylix.nixosModules.stylix
        ../setup.nix
      ];

      networking.nat.forwardPorts = [
        {
          destination = "192.168.100.11:5029";
          sourcePort = 5029;
        }
      ];

      environment.systemPackages = with pkgs; [
        srb2
      ];
    };
  };
}
