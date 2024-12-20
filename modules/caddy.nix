{
  services.caddy = {
    enable = true;

    virtualHosts = {
      "https://" = {
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
