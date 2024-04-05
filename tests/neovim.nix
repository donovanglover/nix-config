# TODO: Ensure that neovim config works without errors on startup
let
  inherit (builtins) attrValues;
in (import ./lib.nix) {
  name = "neovim";

  nodes.machine = { self, pkgs, ... }: {
    imports = attrValues {
      inherit (self.nixosModules) system shell;
    };
  };

  testScript = /* python */ ''
    output = machine.succeed("echo 'Hello world'")
    assert "Hello world" in output
  '';
}
