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

    resolvconf.enable = false;

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

  services.resolved.llmnr = "false";

  services.mullvad-vpn = {
    enable = true;
    enableExcludeWrapper = false;
  };
}
