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

    hypr-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-gaming = {
      url = "github:fufexan/nix-gaming";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, hyprland, stylix, hypr-contrib, nix-gaming, ... }@attrs: let
    variables = import ./examples/laptop.nix;
  in {
    nixosConfigurations."${variables.hostname}" = nixpkgs.lib.nixosSystem {
      system = variables.system;
      specialArgs = attrs;
      modules = [
        home-manager.nixosModules.home-manager
        hyprland.nixosModules.default
        stylix.nixosModules.stylix
        nix-gaming.nixosModules.pipewireLowLatency
        ./applications
        ./common.nix
        ./user.nix
        ./desktop
        ./dev
        ./games.nix
        ./host
        ./terminal
        ./containers/rar.nix
        {
          hardware.opengl.driSupport32Bit = true;

          boot.loader = {
            systemd-boot = {
              enable = true;
              editor = false;
            };

            efi.canTouchEfiVariables = true;
          };

          boot.tmp.useTmpfs = true;

          environment.systemPackages = [
            hypr-contrib.packages."x86_64-linux".grimblast
            nix-gaming.packages."x86_64-linux".osu-stable
          ];

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
