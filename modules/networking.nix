{ config, lib, ... }:

let
  inherit (lib) mkEnableOption mkOption mkIf;
  inherit (lib.types) string;

  cfg = config.modules.networking;
in
{
  options.modules.networking = {
    mullvad = mkEnableOption "mullvad vpn";

    hostName = mkOption {
      type = string;
      default = "nixos";
    };

    allowSRB2Port = mkEnableOption "port for srb2";
    allowZolaPort = mkEnableOption "port for zola";
  };

  config = with cfg; {
    networking = {
      inherit hostName;

      networkmanager = {
        enable = true;
        wifi.macAddress = "random";
        ethernet.macAddress = "random";

        unmanaged = [ "interface-name:ve-*" ];
      };

      useHostResolvConf = true;

      resolvconf.enable = mkIf mullvad false;

      nat = mkIf mullvad {
        enable = true;
        internalInterfaces = [ "ve-+" ];
        externalInterface = "wg-mullvad";
      };

      firewall = {
        allowedUDPPorts = mkIf allowSRB2Port [
          5029
        ];

        allowedTCPPorts = mkIf allowZolaPort [
          1111
        ];
      };
    };

    services.resolved.llmnr = "false";

    services.mullvad-vpn = mkIf mullvad {
      enable = true;
      enableExcludeWrapper = false;
    };
  };
}
