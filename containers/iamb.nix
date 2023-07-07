{ stylix, home-manager, ... }:

{
  containers.iamb = {
    privateNetwork = true;
    ephemeral = true;
    hostAddress = "192.168.100.70";
    localAddress = "192.168.100.71";

    bindMounts = {
      "/home/user" = {
        hostPath = "/home/user/containers/iamb";
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
    };

    config = { pkgs, ... }: {
      imports = [
        stylix.nixosModules.stylix
        home-manager.nixosModules.home-manager
        ../setup.nix
      ];

      environment.systemPackages = with pkgs; [
        iamb
      ];
    };
  };
}
