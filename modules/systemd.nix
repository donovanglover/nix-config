{
  systemd = {
    extraConfig = "DefaultTimeoutStopSec=10s";
    services.NetworkManager-wait-online.enable = false;
  };
}
