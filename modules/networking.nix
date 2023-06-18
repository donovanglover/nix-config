let VARIABLES = import ../src/variables.nix; in {
  networking = {
    hostName = VARIABLES.hostname;

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

      forwardPorts = [
        {
          destination = "192.168.100.11:80";
          sourcePort = 11918;
        }
      ];
    };
  };
}
