{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }@attrs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = attrs;
      modules = [
        ./configuration.nix
        ./modules/editor.nix
        ./modules/desktop.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          users.users.user = {
            isNormalUser = true;
            extraGroups = [ "wheel" "networkmanager" ];
          };
          home-manager.users.user = { pkgs, ... }: {
            home.username = "user";
            home.homeDirectory = "/home/user";
            home.packages = [ pkgs.httpie ];
            home.stateVersion = "22.11";
            programs.mpv.enable = true;
            programs.librewolf = {
              enable = true;
              settings = {
                "middlemouse.paste" = false;
                "browser.download.useDownloadDir" = true;
                "ui.use_activity_cursor" = true;
                "browser.tabs.insertAfterCurrent" = true;
              };
            };
            programs.git = { diff-so-fancy = { enable = true; }; };
            programs.lf = { enable = true; };
            services.udiskie.enable = true;
          };
        }
      ];
    };
  };
}
