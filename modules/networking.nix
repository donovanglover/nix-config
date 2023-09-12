{
  networking = {
    hostName = "nixos";

    networkmanager = {
      enable = true;
      wifi.macAddress = "random";
      ethernet.macAddress = "random";

      unmanaged = [ "interface-name:ve-*" ];
    };

    useHostResolvConf = true;

    nat = {
      enable = true;
      internalInterfaces = [ "ve-+" ];
      externalInterface = "wg-mullvad";
    };

    firewall = {
      allowedUDPPorts = [
        5029
      ];

      allowedTCPPorts = [
        1111
      ];
    };
  };
}
