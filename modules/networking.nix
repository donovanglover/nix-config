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
    };
  };
}
