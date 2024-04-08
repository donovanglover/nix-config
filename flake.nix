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

  outputs = { self, nixpkgs, ... } @ attrs:
    let
      inherit (nixpkgs.lib) nixosSystem;
      inherit (nixpkgs.legacyPackages.x86_64-linux) nixpkgs-fmt callPackage;
      inherit (builtins) attrNames listToAttrs map replaceStrings readDir;

      flakeOutputs = [ "overlays" "nixosModules" "homeManagerModules" "packages" "checks" ];
      flakeDirectories = [ "overlays" "modules" "home" "packages" "tests" ];
    in
    {
      formatter.x86_64-linux = nixpkgs-fmt;

      nixosConfigurations = {
        nixos = nixosSystem {
          system = "x86_64-linux";
          specialArgs = attrs // { nix-config = self; };
          modules = [ ./. ];
        };
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
                    value =
                      if directory == "packages"
                      then callPackage ./${directory}/${file} { }
                      else
                        if directory == "tests"
                        then import ./${directory}/${file} {
                          inherit self;
                          pkgs = nixpkgs.legacyPackages.x86_64-linux;
                        }
                        else import ./${directory}/${file};
                  })
                  (attrNames (readDir ./${directory}))));

              attributeSet =
                if directory == "packages" || directory == "tests"
                then { x86_64-linux = attributeValue; }
                else attributeValue;
            in
            (attributeSet);
        })
        (flakeOutputs)));
}
