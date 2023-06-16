{ home-manager, stylix, ... }:
let
  VARIABLES = import ../src/variables.nix;
in
{
  containers.gui = {
    privateNetwork = true;
    ephemeral = true;

    bindMounts = {
      "/mnt" = {
        hostPath = "/home/${VARIABLES.username}/containers/gui";
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
        ./common/wayland.nix
        ../modules/fonts.nix
        ../modules/stylix.nix
      ];

      environment.systemPackages = with pkgs; [
        audacity # Audio editing
        gimp # Video editing
        anki # Spaced repetition
        sqlitebrowser # SQL
        kanjidraw # Kanji draw
        kitty # TODO: import common module
        libreoffice
      ];

      users = {
        mutableUsers = false;
        allowNoPasswordLogin = true;

        users.user = {
          isNormalUser = true;
          home = "/home/user";
        };
      };

      #home-manager.sharedModules = [{
      #}];

      home-manager.users.user = { pkgs, ... }: {
        home.packages = [ pkgs.atool pkgs.httpie ];
        home.stateVersion = VARIABLES.stateVersion;
      };

      environment = {
        variables = { TERM = "xterm-kitty"; };
        defaultPackages = [ ];
      };

      # environment.systemPackages = with pkgs; [ kitty ];
      system.stateVersion = VARIABLES.stateVersion;
    };
  };
}
