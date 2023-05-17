{
  networking = {
    hostName = "nixos";

    networkmanager = {
      enable = true;
      dns = "none";
    };

    useHostResolvConf = true;
  };
}
