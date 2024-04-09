# TODO: Write test to ensure that Hyprland starts with basic config
let
  inherit (builtins) attrValues;
in
(import ../lib/test.nix) {
  name = "hyprland";

  nodes.machine = { nix-config, ... }: {
    imports = attrValues {
      inherit (nix-config.nixosModules) system desktop;
    };
  };

  testScript = /* python */ ''
    output = machine.succeed("echo 'Hello world'")
    assert "Hello world" in output
  '';
}
