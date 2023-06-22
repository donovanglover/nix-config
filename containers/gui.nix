{ home-manager, stylix, ... }:

{
  containers.gui = {
    privateNetwork = true;
    ephemeral = true;

    bindMounts = {
      "/mnt" = {
        hostPath = "/home/user/containers/gui";
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
      imports = [
        home-manager.nixosModules.home-manager
        stylix.nixosModules.stylix
        ../setup.nix
      ];

      environment.systemPackages = with pkgs; [
        audacity # Audio editing
        gimp # Video editing
        anki # Spaced repetition
        sqlitebrowser # SQL
        kanjidraw # Kanji draw
        libreoffice
      ];
    };
  };
}
