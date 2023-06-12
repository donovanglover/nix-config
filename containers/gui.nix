{ home-manager, ... }:
let
  VARIABLES = import ../src/variables.nix;
in
{
  containers.gui = {
    imports = [
      ./common-container/wayland.nix
    ];

    privateNetwork = true;
    ephemeral = true;
    autoStart = true;

    bindMounts = {
      "/mnt" = {
        hostPath = "/home/${VARIABLES.username}/containers/gui";
        isReadOnly = false;
      };
    };

    config = { pkgs, lib, ... }: {
      imports = [
        home-manager.nixosModules.home-manager
        ./common-config/wayland.nix
      ];

      environment.systemPackages = with pkgs; [
        audacity  # Audio editing
        gimp # Video editing
        anki # Spaced repetition
        sqlitebrowser # SQL
        kanjidraw # Kanji draw
        kitty # TODO: import common module
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
