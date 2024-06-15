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
      nixosConfigurations =
        let
          modules = [
            ./configuration.nix
            ./hardware-configuration.nix
          ];
        in
        {
          mobile-nixos = nixpkgs.lib.nixosSystem {
            system = "aarch64-linux";
            specialArgs = attrs;

            modules = modules ++ [
              (import "${mobile-nixos}/lib/configuration.nix" {
                device = "pine64-pinephone";
              })

              {
                mobile.beautification = {
                  silentBoot = nixpkgs.lib.mkDefault true;
                  splash = nixpkgs.lib.mkDefault true;
                };
              }
            ];
          };

          mobile-nixos-vm = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            specialArgs = attrs;

            inherit modules;
          };
        };
    };
}
