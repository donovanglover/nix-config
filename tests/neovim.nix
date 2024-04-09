# TODO: Ensure that neovim config works without errors on startup
let
  inherit (builtins) attrValues;
in
(import ../lib/test.nix) {
  name = "neovim";

  nodes.machine = { nix-config, ... }: {
    imports = attrValues {
      inherit (nix-config.nixosModules) system shell;
    };
  };

  testScript = /* python */ ''
    output = machine.succeed("echo 'Hello world'")
    assert "Hello world" in output
  '';
}
