{
  nix-config,
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (nix-config.inputs.sakaya.packages.${pkgs.system}) sakaya;
  inherit (config.modules.system) username;
  inherit (lib) singleton getExe;

  sakayaPort = 39493;
in
{
  networking = {
    nat.forwardPorts = singleton {
      destination = "192.168.100.49:${sakayaPort}";
      sourcePort = sakayaPort;
    };

    firewall.allowedTCPPorts = [ sakayaPort ];
  };

  systemd.services.sakaya = {
    enable = true;
    description = "sakaya server";

    unitConfig = {
      Type = "simple";
    };

    path = with pkgs; [ su ];

    serviceConfig = {
      ExecStart = "/usr/bin/env su ${username} --command=${getExe sakaya}";
    };

    wantedBy = [ "multi-user.target" ];
  };

  environment = {
    systemPackages =
      (with pkgs; [
        wineWowPackages.waylandFull
        winetricks
      ])
      ++ [ sakaya ];

    sessionVariables = {
      LC_ALL = "ja_JP.UTF-8";
      TZ = "Asia/Tokyo";
    };
  };
}
