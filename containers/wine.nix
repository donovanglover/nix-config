{ nix-config, config, lib, pkgs, ... }:

let
  inherit (nix-config.inputs) sakaya;
  inherit (config.modules.system) username;
in
{
  networking.nat.forwardPorts = [
    {
      destination = "192.168.100.49:39493";
      sourcePort = 39493;
    }
    {
      destination = "192.168.100.49:5029";
      sourcePort = 5029;
    }
  ];

  networking.firewall.allowedTCPPorts = [
    39493
    5029
  ];

  systemd.services.sakaya = {
    enable = true;
    description = "sakaya server";

    unitConfig = {
      Type = "simple";
    };

    path = with pkgs; [
      su
    ];

    serviceConfig = {
      ExecStart = "/usr/bin/env su ${username} --command=${sakaya.packages.${pkgs.system}.sakaya}/bin/sakaya";
    };

    wantedBy = [ "multi-user.target" ];
  };

  environment.systemPackages = with pkgs; [
    wineWowPackages.waylandFull
    winetricks
    sakaya.packages.${system}.sakaya
    rar
    unrar
    iamb
    srb2
  ];

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "rar"
    "unrar"
  ];

  environment.sessionVariables = {
    LC_ALL = "ja_JP.UTF-8";
    TZ = "Asia/Tokyo";
  };
}
