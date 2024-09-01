{ self, pkgs }:

self.inputs.nixpkgs.lib.nixos.runTest {
  name = "neovim";
  hostPkgs = pkgs;
  node.specialArgs.nix-config = self;

  nodes.machine =
    { nix-config, ... }:
    {
      imports = with nix-config.nixosModules; [
        shell
        system
      ];

      home-manager.sharedModules = with nix-config.homeModules; [
        neovim
      ];
    };

  testScript = # python
    ''
      machine.wait_for_unit("default.target")

      machine.send_chars("user")
      machine.sleep(1)
      machine.send_key("ret")
      machine.sleep(1)
      machine.send_chars("user")
      machine.sleep(1)
      machine.send_key("ret")
      machine.sleep(5)

      machine.send_chars("nvim hello.txt")
      machine.sleep(1)
      machine.send_key("ret")
      machine.sleep(20)

      machine.send_chars("i")
      machine.sleep(2)
      machine.send_chars("Hello world")
      machine.sleep(2)
      machine.send_key("esc")
      machine.sleep(2)
      machine.send_chars(":wq")
      machine.sleep(2)
      machine.send_key("ret")
      machine.sleep(2)

      text = machine.succeed("cat /home/user/hello.txt")

      assert "Hello world" in text
    '';
}
