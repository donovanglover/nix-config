{ home-manager, stylix, nix-gaming, ... }:
let
  VARIABLES = import ../src/variables.nix;
in
{
  containers.osu = {
    privateNetwork = true;
    ephemeral = true;
    autoStart = true;

    bindMounts = {
      "/home/user/.osu" = {
        hostPath = "/home/${VARIABLES.username}/containers/osu";
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

    config = { pkgs, lib, ... }: {
      imports = [
        home-manager.nixosModules.home-manager
        stylix.nixosModules.stylix
        ./common/wayland.nix
        ../modules/fonts
        ../modules/stylix
      ];

      environment.systemPackages = with pkgs; [
        nix-gaming.packages."${VARIABLES.system}".osu-stable
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
        home.stateVersion = VARIABLES.stateVersion;
      };

      environment = {
        variables = { TERM = "xterm-kitty"; };
        defaultPackages = [ ];
      };

      system.stateVersion = VARIABLES.stateVersion;
    };
  };
}
