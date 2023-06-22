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
        ../modules/pipewire.nix
      ];

      programs = {
        fish.enable = true;
        neovim.enable = true;
        starship.enable = true;
      };


      users = {
        defaultUserShell = pkgs.fish;
        mutableUsers = false;
        allowNoPasswordLogin = true;

        users.user = {
          isNormalUser = true;
          home = "/home/user";
        };
      };

      environment = {
        shells = with pkgs; [ fish ];

        variables = {
          TERM = "xterm-kitty";
        };

        defaultPackages = [ ];
      };

      environment.systemPackages = with pkgs; [
        kitty
        wineWowPackages.stagingFull
        winetricks
      ];

      environment.sessionVariables = {
        WAYLAND_DISPLAY = "wayland-1";
        QT_QPA_PLATFORM = "wayland";
        QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
        SDL_VIDEODRIVER = "wayland";
        CLUTTER_BACKEND = "wayland";
        MOZ_ENABLE_WAYLAND = "1";
        XDG_RUNTIME_DIR = "/run/user/1000";
        DISPLAY = ":0";
      };

      services.xserver.enable = true;

      hardware.opengl = {
        enable = true;
        driSupport32Bit = true;
      };

      system.stateVersion = "22.11";
    };
  };
}
