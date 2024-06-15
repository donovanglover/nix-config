{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    mobile-nixos = {
      url = "github:NixOS/mobile-nixos";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, mobile-nixos } @ attrs:
  {
    nixosConfigurations = {
      mobile-nixos = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        specialArgs = attrs;
        modules = [
          (import "${mobile-nixos}/lib/configuration.nix" {
            device = "pine64-pinephone";
          })

          {
            mobile.beautification = {
              silentBoot = nixpkgs.lib.mkDefault true;
              splash = nixpkgs.lib.mkDefault true;
            };
          }

          ./configuration.nix
          ./hardware-configuration.nix
        ];
      };
    };
  };
}
