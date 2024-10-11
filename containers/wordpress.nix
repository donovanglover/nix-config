{
  nix-config,
  pkgs,
  ...
}:

{
  imports = with nix-config.nixosModules; [
    system
  ];

  users.defaultUserShell = pkgs.fish;

  programs = {
    fish.enable = true;
    neovim.enable = true;
  };

  environment = {
    systemPackages = with pkgs; [ kitty ];
    shells = with pkgs; [ fish ];

    variables = {
      TERM = "xterm-kitty";
    };
  };

  networking = {
    firewall.allowedTCPPorts = [ 80 ];
  };

  services.wordpress.sites.localhost = { };
}
