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

  outputs = { self, nixpkgs, home-manager, stylix, ... } @ attrs: with nixpkgs.lib; with nixpkgs.legacyPackages.x86_64-linux; {
    nixosConfigurations = {
      nixos = nixosSystem {
        system = "x86_64-linux";
        specialArgs = attrs;
        modules = [
          home-manager.nixosModules.home-manager
          stylix.nixosModules.stylix
          ./hardware/laptop.nix
          {
            environment.pathsToLink = [
              "/share/backgrounds"
              "/share/eww"
              "/share/thumbnailers"
              "/share/fonts"
            ];

            nixpkgs.overlays = builtins.attrValues self.overlays;
            imports = builtins.attrValues self.nixosModules;
            home-manager.sharedModules = builtins.attrValues self.homeManagerModules;
            environment.systemPackages = builtins.attrValues self.packages.x86_64-linux;
          }
        ];
      };
    };

    formatter.x86_64-linux = nixpkgs-fmt;
  } //
    (builtins.listToAttrs
      (builtins.map
        (attributeName: {
          name = attributeName;
          value = let
            directory = builtins.replaceStrings ["nixosModules" "homeManagerModules"] ["modules" "home"] attributeName;
            attributeValue = (builtins.listToAttrs
              (builtins.map
                (file: {
                  name = builtins.replaceStrings [".nix"] [""] file;
                  value = if directory == "packages" then callPackage ./${directory}/${file} { } else import ./${directory}/${file}; })
                (builtins.attrNames (builtins.readDir ./${directory}))));
            attributeSet = if directory == "packages" then { x86_64-linux = attributeValue; } else attributeValue;
          in (attributeSet); })
      ["overlays" "nixosModules" "homeManagerModules" "packages"]));
}
