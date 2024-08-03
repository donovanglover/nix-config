test:

{ self, pkgs }:

let
  inherit (pkgs.lib) mkDefault;

  nixos-lib = import (pkgs.path + "/nixos/lib") { };
in
(nixos-lib.runTest {
  imports = [ test ];

  hostPkgs = pkgs;
  defaults.documentation.enable = mkDefault false;

  node.specialArgs = {
    nix-config = self;
  };
}).config.result
