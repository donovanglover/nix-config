{ self, pkgs }:

self.inputs.nixpkgs.lib.nixos.runTest {
  name = "neovim";
  hostPkgs = pkgs;
  node.specialArgs.nix-config = self;

  nodes.machine =
    { nix-config, config, ... }:
    {
      imports = with nix-config.nixosModules; [
        shell
        system
        stylix
      ];

      home-manager.sharedModules = with nix-config.homeModules; [
        neovim
      ];

      services.getty.autologinUser = config.modules.system.username;
    };

  testScript = # python
    ''
      machine.wait_for_unit("default.target")

      machine.send_chars("nvim hello.txt\n")
      machine.sleep(30)

      machine.send_chars("i")
      machine.sleep(2)
      machine.send_chars("Hello world")
      machine.sleep(2)
      machine.send_key("esc")
      machine.sleep(2)
      machine.send_chars(":wq\n")
      machine.sleep(2)

      text = machine.succeed("cat /home/user/hello.txt")

      assert "Hello world" in text
    '';
}
