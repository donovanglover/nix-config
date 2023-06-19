{
  systemd = {
    # Limit shutdown wait time to 10 seconds
    extraConfig = "DefaultTimeoutStopSec=10s";

    # Don't wait for an internet connection before obtaining a graphical interface
    services.NetworkManager-wait-online.enable = false;
  };
}
