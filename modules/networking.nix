{ config, ... }: {
  networking = {
    hostName = config.variables.hostname;

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
