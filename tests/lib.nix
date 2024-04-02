test: { pkgs, self }:
let
  inherit (pkgs) lib;
  nixos-lib = import (pkgs.path + "/nixos/lib") { };
in
(nixos-lib.runTest {
  hostPkgs = pkgs;
  defaults.documentation.enable = lib.mkDefault false;
  node.specialArgs = {
    inherit self;
  };
  imports = [ test ];
}).config.result
