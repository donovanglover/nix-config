{ home-manager, stylix, ... }:

{
  containers.dev = {
    privateNetwork = true;
    ephemeral = true;
    hostAddress = "192.168.100.30";
    localAddress = "192.168.100.31";

    bindMounts = {
      "/mnt" = {
        hostPath = "/home/user/containers/dev";
        isReadOnly = false;
      };
    };

    config = { pkgs, ... }: {
      imports = [
        home-manager.nixosModules.home-manager
        stylix.nixosModules.stylix
        ../setup.nix
        ../modules/nix.nix
        ../modules/fish.nix
      ];

      home-manager.sharedModules = [
        ../home/git.nix
        ../home/neovim.nix
        ../home/htop.nix
      ];
    };
  };
}
