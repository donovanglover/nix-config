{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:donovanglover/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:donovanglover/stylix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };

    sakaya = {
      url = "github:donovanglover/sakaya";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    mobile-nixos = {
      url = "github:donovanglover/mobile-nixos";
      flake = false;
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      mobile-nixos,
      ...
    }@attrs:
    let
      inherit (nixpkgs.lib) nixosSystem;
      inherit (nixpkgs.lib.filesystem) packagesFromDirectoryRecursive listFilesRecursive;
      inherit (nixpkgs.legacyPackages) x86_64-linux aarch64-linux;

      inherit (builtins)
        attrNames
        listToAttrs
        map
        replaceStrings
        readDir
        ;

      flakeOutputs = [
        "overlays"
        "nixosModules"
        "homeModules"
      ];

      flakeDirectories = [
        "overlays"
        "modules"
        "home"
      ];

      forAllSystems = function:
        nixpkgs.lib.genAttrs [
          "x86_64-linux"
          "aarch64-linux"
        ] (system: function nixpkgs.legacyPackages.${system});
    in
    {
      packages = forAllSystems (pkgs: packagesFromDirectoryRecursive {
        callPackage = pkgs.callPackage;
        directory = ./packages;
      });

      checks.x86_64-linux = listToAttrs (map (file: {
        name = replaceStrings [ ".nix" ] [ "" ] (baseNameOf (toString file));

        value = import file {
          inherit self;
          pkgs = x86_64-linux;
        };
      }) (listFilesRecursive ./tests));

      nixosConfigurations =
        let
          phoneModules = [
            ./hosts/phone/configuration.nix
            ./hosts/phone/hardware-configuration.nix
          ];
        in
        {
          nixos = nixosSystem {
            system = "x86_64-linux";

            specialArgs = attrs // {
              nix-config = self;
            };

            modules = [
              ./hosts/laptop/configuration.nix
              ./hosts/laptop/hardware-configuration.nix
            ];
          };

          mobile-nixos = nixosSystem {
            system = "aarch64-linux";

            specialArgs = attrs // {
              nix-config = self;
            };

            modules = phoneModules ++ [
              (import "${mobile-nixos}/lib/configuration.nix" {
                device = "pine64-pinephone";
              })

              {
                mobile.beautification = {
                  silentBoot = true;
                  splash = true;
                };
              }
            ];
          };

          mobile-nixos-vm = nixosSystem {
            system = "x86_64-linux";

            specialArgs = attrs // {
              nix-config = self;
            };

            modules = phoneModules;
          };
        };

      formatter = {
        x86_64-linux = x86_64-linux.nixfmt-rfc-style;
        aarch64-linux = aarch64-linux.nixfmt-rfc-style;
      };
    }
    // (listToAttrs (
      map (attributeName: {
        name = attributeName;
        value =
          let
            directory = replaceStrings flakeOutputs flakeDirectories attributeName;

            attributeValue = listToAttrs (
              map (file: {
                name = replaceStrings [ ".nix" ] [ "" ] file;
                value = import ./${directory}/${file};
              }) (attrNames (readDir ./${directory}))
            );

            attributeSet = attributeValue;
          in
          attributeSet;
      }) flakeOutputs
    ));
}
