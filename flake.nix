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

    mobile-nixos = {
      url = "github:donovanglover/mobile-nixos";
      flake = false;
    };

    flake-programs-sqlite = {
      url = "github:wamserma/flake-programs-sqlite";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, mobile-nixos, ... } @ attrs:
    let
      inherit (nixpkgs.lib) nixosSystem;
      inherit (nixpkgs.legacyPackages) x86_64-linux aarch64-linux;
      inherit (builtins) attrNames listToAttrs map replaceStrings readDir;

      flakeOutputs = [ "overlays" "nixosModules" "homeManagerModules" "packages" "checks" ];
      flakeDirectories = [ "overlays" "modules" "home" "packages" "tests" ];
    in
    {
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
            specialArgs = attrs // { nix-config = self; };

            modules = [
              ./hosts/laptop/configuration.nix
              ./hosts/laptop/hardware-configuration.nix
            ];
          };

          mobile-nixos = nixosSystem {
            system = "aarch64-linux";
            specialArgs = attrs // { nix-config = self; };

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
            specialArgs = attrs // { nix-config = self; };
            modules = phoneModules ++ [
              {
                boot.loader.systemd-boot.enable = true;
              }
            ];
          };
        };

      formatter.x86_64-linux = x86_64-linux.nixpkgs-fmt;
      formatter.aarch64-linux = aarch64-linux.nixpkgs-fmt;
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
                    value =
                      if directory == "packages"
                      then x86_64-linux.callPackage ./${directory}/${file} { }
                      else
                        if directory == "tests"
                        then
                          import ./${directory}/${file}
                            {
                              inherit self;
                              pkgs = x86_64-linux;
                            }
                        else import ./${directory}/${file};
                  })
                  (attrNames (readDir ./${directory}))));

              aarch64Packages = (listToAttrs
                (map
                  (file: {
                    name = replaceStrings [ ".nix" ] [ "" ] file;
                    value =
                      if directory == "packages"
                      then aarch64-linux.callPackage ./${directory}/${file} { }
                      else null;
                  })
                  (attrNames (readDir ./${directory}))));

              attributeSet =
                if directory == "packages"
                then {
                  x86_64-linux = attributeValue;
                  aarch64-linux = aarch64Packages;
                }
                else
                  if directory == "tests"
                  then {
                    x86_64-linux = attributeValue;
                  }
                  else attributeValue;
            in
            (attributeSet);
        })
        (flakeOutputs)));
}
