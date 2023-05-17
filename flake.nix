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

  outputs = { self, nixpkgs, home-manager, hyprland, stylix, ... }@attrs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = attrs;
      modules = [
        ./home-manager
        hyprland.nixosModules.default
        stylix.nixosModules.stylix
        home-manager.nixosModules.home-manager
        ./laptop.nix
        ./modules/starship.nix
        ./modules/fish.nix
        ./modules/fonts.nix
        ./modules/stylix
        ./modules/htop.nix
        ./modules/dual-function-keys.nix
        ./modules/tlp.nix
        ./modules/osu
        ./modules/srb2
        ./modules/mullvad
        ./modules/pipewire
        ./modules/networking
        ./modules/virtualization
        ./modules/xserver
        ./modules/systemd
        ./modules/vnstat
        ./modules/locale
        ./modules/firejail
        ./modules/timezone
        ./modules/nix
        ./modules/npm
        ./modules/home-manager
        ./modules/piper
        ./modules/packages
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
