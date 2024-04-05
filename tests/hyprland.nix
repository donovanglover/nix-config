# TODO: Write test to ensure that Hyprland starts with basic config
let
  inherit (builtins) attrValues;
in (import ./lib.nix) {
  name = "hyprland";

  nodes.machine = { self, pkgs, ... }: {
    imports = attrValues {
      inherit (self.nixosModules) system desktop;
    };
  };

  testScript = /* python */ ''
    output = machine.succeed("echo 'Hello world'")
    assert "Hello world" in output
  '';
}
