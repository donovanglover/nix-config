let
  VARIABLES = import ../src/variables.nix;
in {
  containers.rar = {
    privateNetwork = true;

    bindMounts = {
      "/home/user" = {
        hostPath = "/home/${VARIABLES.username}/containers/rar";
        isReadOnly = false;
      };
    };

    config = {
      pkgs,
      lib,
      ...
    }: {
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
        shells = with pkgs; [fish];

        variables = {
          TERM = "xterm-kitty";
        };

        defaultPackages = [];
      };

      environment.systemPackages = with pkgs; [
        kitty
        rar
        unrar
      ];

      nixpkgs.config.allowUnfreePredicate = pkg:
        builtins.elem (lib.getName pkg) [
          "rar"
          "unrar"
        ];

      system.stateVersion = VARIABLES.stateVersion;
    };
  };
}
