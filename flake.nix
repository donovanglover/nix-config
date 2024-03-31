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

  outputs = { nixpkgs, ... } @ attrs: with nixpkgs.lib; {
    nixosConfigurations = {
      nixos = nixosSystem {
        system = "x86_64-linux";
        specialArgs = attrs;
        modules = [ ./. ];
      };
    };

    packages."x86_64-linux" = with nixpkgs.legacyPackages."x86_64-linux"; {
      aleo-fonts = callPackage ./packages/aleo-fonts.nix { };
      fluent-icons = callPackage ./packages/fluent-icons.nix { };
      hycov = callPackage ./packages/hycov.nix { };
      osu-backgrounds = callPackage ./packages/osu-backgrounds.nix { };
      webp-thumbnailer = callPackage ./packages/webp-thumbnailer.nix { };
    };

    overlays = {
      base16-schemes = import ./overlays/base16-schemes.nix;
      kitty = import ./overlays/kitty.nix;
      srb2 = import ./overlays/srb2.nix;
      zola = import ./overlays/zola.nix;
    };
  };
}
