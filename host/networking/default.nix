{
  networking = {
    hostName = "nixos";

    networkmanager = {
      enable = true;
      dns = "none";
      wifi.macAddress = "random";
      ethernet.macAddress = "random";
    };

    useHostResolvConf = true;
  };

  services.resolved.llmnr = "false";
}