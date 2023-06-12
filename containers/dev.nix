{ home-manager, ... }:
let
  VARIABLES = import ../src/variables.nix;
in
{
  containers.dev = {
    privateNetwork = true;
    ephemeral = true;
    autoStart = true;
    hostAddress = "192.168.100.30";
    localAddress = "192.168.100.31";

    bindMounts = {
      "/mnt" = {
        hostPath = "/home/${VARIABLES.username}/containers/dev";
        isReadOnly = false;
      };
    };

    config = { pkgs, lib, ... }: {
      imports = [
        home-manager.nixosModules.home-manager
        ../modules/git
        ../modules/neovim
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

      home-manager.users.user = { pkgs, ... }: {
        home.packages = [ pkgs.atool pkgs.httpie ];
        home.stateVersion = VARIABLES.stateVersion;
      };

      environment = {
        shells = with pkgs; [ fish ];

        variables = { TERM = "xterm-kitty"; };

        defaultPackages = [ ];
      };

      environment.systemPackages = with pkgs; [ kitty ];

      system.stateVersion = VARIABLES.stateVersion;
    };
  };
}
