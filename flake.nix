{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };
  };

  outputs = inputs: {
    nixosConfigurations.nixos = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        inputs.home-manager.nixosModules.home-manager
        inputs.hyprland.nixosModules.default
        inputs.stylix.nixosModules.stylix
        ./applications
        ./common
        ./desktop
        ./dev
        ./games
        ./host
        ./terminal
        {
          boot.loader.systemd-boot.enable = true;
          boot.loader.efi.canTouchEfiVariables = true;

          environment.sessionVariables = {
            EDITOR = "nvim";
            VISUAL = "nvim";
            GIT_DISCOVERY_ACROSS_FILESYSTEM = "1";
            FZF_DEFAULT_OPTS = "--height 40% --reverse --border --color=16";
            NODE_OPTIONS = "--max_old_space_size=16384";
          };

          environment.defaultPackages = [ ];
          system.stateVersion = "22.11";
        }
      ];
    };
  };
}
