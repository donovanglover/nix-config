{ pkgs, ... }:

{
  environment.systemPackages = [ pkgs.mullvad-vpn ];

  services.mullvad-vpn = {
    enable = true;
    enableExcludeWrapper = false;
  };

  networking.firewall.allowedTCPPorts = [ 11918 ];

  networking = {
    nat = {
      enable = true;
      internalInterfaces = [ "ve-+" ];
      externalInterface = "wg-mullvad";

      forwardPorts = [
        {
          destination = "192.168.100.11:80";
          sourcePort = 11918;
        }
      ];
    };

    networkmanager = {
      unmanaged = [ "interface-name:ve-*" ];
    };
  };
}
