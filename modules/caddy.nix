{
  services.caddy = {
    enable = true;

    virtualHosts = {
      "https://" = {
        logFormat = "output file /var/log/caddy/access.log";

        extraConfig = # Caddyfile
          ''
            reverse_proxy :3000

            tls internal {
              on_demand
            }
          '';
      };
    };
  };
}
