{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };

    sakaya = {
      url = "github:donovanglover/sakaya";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, stylix, ... } @ attrs:
    let
      inherit (nixpkgs.lib) nixosSystem;
      inherit (nixpkgs.legacyPackages.x86_64-linux) nixpkgs-fmt callPackage;
      inherit (builtins) attrValues attrNames listToAttrs map replaceStrings readDir;

      checkArgs = {
        inherit self;

        pkgs = nixpkgs.legacyPackages.x86_64-linux;
      };

      flakeOutputs = [ "overlays" "nixosModules" "homeManagerModules" "packages" ];
      flakeDirectories = [ "overlays" "modules" "home" "packages" ];
      packageDirectory = "packages";
    in
    {
      formatter.x86_64-linux = nixpkgs-fmt;

      nixosConfigurations = {
        nixos = nixosSystem {
          system = "x86_64-linux";
          specialArgs = attrs // { nix-config = self; };
          modules = [
            ./hardware/laptop.nix
            {
              environment.pathsToLink = [
                "/share/backgrounds"
                "/share/eww"
                "/share/thumbnailers"
                "/share/fonts"
              ];

              nixpkgs.overlays = attrValues self.overlays;
              imports = attrValues self.nixosModules;
              home-manager.sharedModules = attrValues self.homeManagerModules;
              environment.systemPackages = attrValues self.packages.x86_64-linux;

              modules = {
                hardware = {
                  disableLaptopKeyboard = true;
                  lidIgnore = true;
                  powerIgnore = true;
                };

                networking = {
                  mullvad = true;
                };

                desktop = {
                  japanese = true;
                  bloat = true;
                  wine = true;
                };
              };
            }
          ];
        };
      };

      checks.x86_64-linux = {
        hyprland = import ./tests/hyprland.nix checkArgs;
        neovim = import ./tests/neovim.nix checkArgs;
      };
    } //
    (listToAttrs
      (map
        (attributeName: {
          name = attributeName;
          value =
            let
              directory = replaceStrings flakeOutputs flakeDirectories attributeName;
              attributeValue = (listToAttrs
                (map
                  (file: {
                    name = replaceStrings [ ".nix" ] [ "" ] file;
                    value = if directory == packageDirectory then callPackage ./${directory}/${file} { } else import ./${directory}/${file};
                  })
                  (attrNames (readDir ./${directory}))));
              attributeSet = if directory == packageDirectory then { x86_64-linux = attributeValue; } else attributeValue;
            in
            (attributeSet);
        })
        (flakeOutputs)));
}
