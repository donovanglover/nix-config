let
  inherit (builtins) attrValues;
in
(import ../lib/test.nix) {
  name = "neovim";

  nodes.machine =
    { nix-config, ... }:
    {
      imports = attrValues {
        inherit (nix-config.nixosModules) desktop system shell;

        customConfig = {
          modules.desktop.container = true;
        };
      };

      home-manager.sharedModules = with nix-config.homeModules; [ neovim ];
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
