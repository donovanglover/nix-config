# TODO: Ensure that neovim config works without errors on startup
(import ./lib.nix) {
  name = "neovim";

  nodes.machine = { self, pkgs, ... }: {
    imports = with self.nixosModules; [
      neovim
    ];
  };

  testScript = /* python */ ''
    output = machine.succeed("echo 'Hello world'")
    assert "Hello world" in output
  '';
}
