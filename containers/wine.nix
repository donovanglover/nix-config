{ stylix, home-manager, sakaya, ... }:

{
  containers.wine = {
    privateNetwork = true;
    ephemeral = true;
    hostAddress = "192.168.100.34";
    localAddress = "192.168.100.49";

    bindMounts = {
      "/mnt" = {
        hostPath = "/home/user/containers/wine";
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
        stylix.nixosModules.stylix
        home-manager.nixosModules.home-manager
        ../setup.nix
        ../modules/pipewire.nix
      ];

      networking.nat.forwardPorts = [
        {
          destination = "192.168.100.49:39493";
          sourcePort = 39493;
        }
      ];

      networking.firewall = {
        allowedTCPPorts = [ 39493 ];
      };

      environment.systemPackages = with pkgs; [
        wineWowPackages.stagingFull
        winetricks
        sakaya.packages."x86_64-linux".sakaya
      ];

      environment.sessionVariables = {
        LC_ALL = "ja_JP.UTF-8";
        TZ = "Asia/Tokyo";
        WINEPREFIX = "/mnt/wine";
      };
    };
  };
}
