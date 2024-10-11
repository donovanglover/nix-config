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
      inputs.nixpkgs.follows = "nixpkgs";
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
      inherit (builtins) listToAttrs map replaceStrings;

      forAllSystems =
        function:
        nixpkgs.lib.genAttrs [
          "x86_64-linux"
          "aarch64-linux"
        ] (system: function nixpkgs.legacyPackages.${system});

      nameOf = path: replaceStrings [ ".nix" ] [ "" ] (baseNameOf (toString path));
    in
    {
      packages = forAllSystems (
        pkgs:
        packagesFromDirectoryRecursive {
          inherit (pkgs) callPackage;

          directory = ./packages;
        }
      );

      nixosModules = listToAttrs (
        map (file: {
          name = nameOf file;
          value = import file;
        }) (listFilesRecursive ./modules)
      );

      homeModules = listToAttrs (
        map (file: {
          name = nameOf file;
          value = import file;
        }) (listFilesRecursive ./home)
      );

      overlays = listToAttrs (
        map (file: {
          name = nameOf file;
          value = import file;
        }) (listFilesRecursive ./overlays)
      );

      checks.x86_64-linux = listToAttrs (
        map (file: {
          name = nameOf file;

          value = import file {
            inherit self;
            pkgs = nixpkgs.legacyPackages.x86_64-linux;
          };
        }) (listFilesRecursive ./tests)
      );

      nixosConfigurations = {
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

          modules = [
            ./hosts/phone/configuration.nix
            ./hosts/phone/hardware-configuration.nix

            mobile-nixos.nixosModules.pine64-pinephone
            mobile-nixos.nixosModules.module-list

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

          modules = [
            ./hosts/phone/configuration.nix
            ./hosts/phone/hardware-configuration.nix
          ];
        };
      };

      formatter = forAllSystems (pkgs: pkgs.nixfmt-rfc-style);
    };
}
