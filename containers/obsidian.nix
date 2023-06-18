{ lib, ... }:
let VARIABLES = import ../src/variables.nix; in {
  containers.obsidian = {
    privateNetwork = true;
    ephemeral = true;

    bindMounts = {
      "/mnt" = {
        hostPath = "/home/${VARIABLES.username}/containers/obsidian";
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
    };

    config = { pkgs, ... }: {
      i18n.defaultLocale = VARIABLES.defaultLocale;
      i18n.supportedLocales = VARIABLES.supportedLocales;

      users = {
        mutableUsers = false;
        allowNoPasswordLogin = true;

        users.user = {
          isNormalUser = true;
          home = "/home/user";
        };
      };

      environment = {
        variables = {
          TERM = "xterm-kitty";
        };

        defaultPackages = [ ];
      };

      environment.systemPackages = with pkgs; [
        kitty
        obsidian
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

      nixpkgs.config.allowUnfreePredicate = pkg:
        builtins.elem (lib.getName pkg) [
          "obsidian"
        ];

      system.stateVersion = VARIABLES.stateVersion;
    };
  };
}
