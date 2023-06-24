{
  containers.rar = {
    privateNetwork = true;

    bindMounts = {
      "/home/user" = {
        hostPath = "/home/user/containers/rar";
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
        rar
      ];

      nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
        "rar"
      ];

      system.stateVersion = "22.11";
    };
  };
}
