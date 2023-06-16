{ home-manager, ... }:
let
  VARIABLES = import ../src/variables.nix;
in
{
  containers.dev = {
    privateNetwork = true;
    ephemeral = true;
    hostAddress = "192.168.100.30";
    localAddress = "192.168.100.31";

    bindMounts = {
      "/mnt" = {
        hostPath = "/home/${VARIABLES.username}/containers/dev";
        isReadOnly = false;
      };
    };

    config = { pkgs, ... }: {
      imports = [
        home-manager.nixosModules.home-manager
        ../modules/fish.nix
      ];

      home-manager.sharedModules = [
        ../home/git.nix
        ../home/neovim.nix
      ];

      users = {
        mutableUsers = false;
        allowNoPasswordLogin = true;

        users.user = {
          isNormalUser = true;
          home = "/home/user";
        };
      };

      home-manager.users.user = { pkgs, ... }: {
        home.packages = [ pkgs.atool pkgs.httpie ];
        home.stateVersion = VARIABLES.stateVersion;
      };

      environment = {
        variables = { TERM = "xterm-kitty"; };
        defaultPackages = [ ];
      };

      environment.systemPackages = with pkgs; [ kitty ];
      system.stateVersion = VARIABLES.stateVersion;
    };
  };
}
