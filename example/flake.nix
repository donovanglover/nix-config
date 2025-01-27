{
  description = "An example of creating your own flake that extends this nix-config";

  inputs = {
    nix-config.url = "github:donovanglover/nix-config";
  };

  outputs =
    { nix-config, ... }@attrs:
    let
      inherit (nix-config.inputs) nixpkgs;
      inherit (nixpkgs.lib) nixosSystem optional;
      inherit (builtins) pathExists;
    in
    {
      nixosConfigurations = {
        hyprland = nixosSystem {
          system = "x86_64-linux";
          specialArgs = attrs;

          modules = [
            ./configuration.nix
          ] ++ optional (pathExists ./hardware-configuration.nix) ./hardware-configuration.nix;
        };
      };
    };
}
