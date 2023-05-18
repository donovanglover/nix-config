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
        ./bat
        ./dunst
        ./editorconfig
        ./fcitx5
        ./feh
        ./fish
        ./git
        ./gpg-agent
        ./gpg
        ./gtk
        ./hyprland
        ./kitty
        ./librewolf
        ./mozc
        ./mpd
        ./mpv
        ./ncmpcpp
        ./neovim
        ./qutebrowser
        ./ranger
        ./rofi
        ./swaylock
        ./thunar
        ./tig
        ./udiskie
        ./waybar
        ./xcursor
        ./xdg-user-dirs
        ./xresources
        ./zathura
        ./starship
        ./fonts
        ./stylix
        ./htop
        ./dual-function-keys
        ./tlp
        ./osu
        ./srb2
        ./mullvad
        ./pipewire
        ./networking
        ./virtualization
        ./xserver
        ./systemd
        ./vnstat
        ./locale
        ./firejail
        ./timezone
        ./nix
        ./npm
        ./home-manager
        ./user
        ./piper
        ./packages
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
