{ home-manager, stylix, ... }: {
  containers.srb2 = {
    privateNetwork = true;
    ephemeral = true;

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
        isReadOnly = true;
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
        ./common/wayland.nix
        ../modules/fonts.nix
        ../modules/stylix.nix
      ];

      environment.systemPackages = with pkgs; [
        srb2
        kitty
      ];

      users = {
        mutableUsers = false;
        allowNoPasswordLogin = true;

        users.user = {
          isNormalUser = true;
          home = "/home/user";
        };
      };

      home-manager.users.user = { ... }: {
        home.stateVersion = "22.11";
      };

      environment = {
        variables = { TERM = "xterm-kitty"; };
        defaultPackages = [ ];
      };

      system.stateVersion = "22.11";
    };
  };
}
