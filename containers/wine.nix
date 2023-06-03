{
  containers.wine = {
    autoStart = true;
    privateNetwork = true;

    bindMounts = {
      "/home/user" = {
        hostPath = "/home/user/containers/wine";
        isReadOnly = false;
      };
    };

    config = { pkgs, lib, ... }: {
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
        wine-staging
        winetricks
      ];

      system.stateVersion = "22.11";
    };
  };
}
