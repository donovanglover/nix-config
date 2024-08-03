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
  inherit (pkgs) su winetricks wineWowPackages;

  sakayaPort = 39493;
in
{
  modules.desktop.graphical = true;

  networking.nat.forwardPorts = singleton {
    destination = "192.168.100.49:${sakayaPort}";
    sourcePort = sakayaPort;
  };

  networking.firewall.allowedTCPPorts = [ sakayaPort ];

  systemd.services.sakaya = {
    enable = true;
    description = "sakaya server";

    unitConfig = {
      Type = "simple";
    };

    path = [ su ];

    serviceConfig = {
      ExecStart = "/usr/bin/env su ${username} --command=${getExe sakaya}";
    };

    wantedBy = [ "multi-user.target" ];
  };

  environment.systemPackages = [
    wineWowPackages.waylandFull
    winetricks
    sakaya
  ];

  environment.sessionVariables = {
    LC_ALL = "ja_JP.UTF-8";
    TZ = "Asia/Tokyo";
  };
}
