{ home-manager, ... }:

{
  containers.dev = {
    privateNetwork = true;
    ephemeral = true;
    hostAddress = "192.168.100.30";
    localAddress = "192.168.100.31";

    bindMounts = {
      "/mnt" = {
        hostPath = "/home/user/containers/dev";
        isReadOnly = false;
      };
    };

    config = { pkgs, ... }: {
      imports = [
        home-manager.nixosModules.home-manager
        ../modules/nix.nix
        ../modules/fish.nix
      ];

      home-manager.sharedModules = [
        ../home/git.nix
        ../home/neovim.nix
        ../home/htop.nix
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
        home.stateVersion = "22.11";
      };

      environment = {
        variables = { TERM = "xterm-kitty"; };
        defaultPackages = [ ];
      };

      environment.systemPackages = with pkgs; [ kitty ];
      system.stateVersion = "22.11";
    };
  };
}
