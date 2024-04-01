{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:bluskript/stylix";
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

  outputs = { self, nixpkgs, ... } @ attrs: with nixpkgs.lib; {
    nixosConfigurations = {
      nixos = nixosSystem {
        system = "x86_64-linux";
        specialArgs = attrs;
        modules = [
          ./.
          {
            nixpkgs.overlays = builtins.attrValues self.overlays;
            imports = builtins.attrValues self.nixosModules;
            home-manager.sharedModules = builtins.attrValues self.homeManagerModules;
          }
        ];
      };
    };

    packages."x86_64-linux" = with nixpkgs.legacyPackages."x86_64-linux";
      builtins.mapAttrs (name: value: callPackage ./packages/${name}) (builtins.readDir ./packages);
  } //
    (builtins.listToAttrs
      (builtins.map
        (attr: {
          name = attr;
          value = let
            directory = builtins.replaceStrings
              ["nixosModules" "homeManagerModules"]
              ["modules" "home"]
              attr;
          in (builtins.listToAttrs
            (builtins.map
              (filename: {
                name = builtins.replaceStrings [".nix"] [""] filename;
                value = import ./${directory}/${filename}; })
              (builtins.attrNames
                (builtins.readDir ./${directory})))); })
      ["overlays" "nixosModules" "homeManagerModules"]));
}
