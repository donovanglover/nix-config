# TODO: Write test to ensure that Hyprland starts with basic config
(import ./lib.nix) {
  name = "hyprland";

  nodes.machine = { self, pkgs, ... }: {
    imports = with self.nixosModules; [
      hyprland
    ];
  };

  testScript = /* python */ ''
    output = machine.succeed("echo 'Hello world'")
    assert "Hello world" in output
  '';
}
