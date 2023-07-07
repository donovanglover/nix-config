{ stylix, home-manager, ... }:

{
  containers.wine = {
    privateNetwork = true;
    ephemeral = true;

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

      environment.systemPackages = with pkgs; [
        wineWowPackages.stagingFull
        winetricks
      ];

      environment.sessionVariables = {
        LC_ALL = "ja_JP.UTF-8";
        TZ = "Asia/Tokyo";
        WINEPREFIX = "/home/user/wine";
      };
    };
  };
}
