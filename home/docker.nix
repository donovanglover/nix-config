let
  inherit (builtins) toJSON;
in
{
  xdg.configFile."docker/compose.yml".text = toJSON {
    services = {
      umami = {
        image = "ghcr.io/umami-software/umami:postgresql-latest";
        container_name = "umami";
        restart = "always";

        ports = [
          "3000:3000"
        ];

        environment = {
          DATABASE_URL = "postgresql://umami:umami@umami-postgres:5432/umami";
          DATABASE_TYPE = "postgresql";
          APP_SECRET = "replace-me-with-a-random-string";
        };

        depends_on = {
          umami-postgres = {
            condition = "service_healthy";
          };
        };

        healthcheck = {
          test = [
            "CMD-SHELL"
            "curl http://localhost:3000/api/heartbeat"
          ];

          interval = "5s";
          timeout = "5s";
          retries = 5;
        };
      };

      umami-postgres = {
        image = "postgres:17-alpine";
        container_name = "umami-postgres";
        restart = "always";

        environment = {
          POSTGRES_DB = "umami";
          POSTGRES_USER = "umami";
          POSTGRES_PASSWORD = "umami";
        };

        volumes = [
          "umami-postgres:/var/lib/postgresql/data"
        ];

        healthcheck = {
          test = [
            "CMD-SHELL"
            "pg_isready -U $${POSTGRES_USER} -d $${POSTGRES_DB}"
          ];

          interval = "5s";
          timeout = "5s";
          retries = 5;
        };
      };
    };

    volumes = {
      umami-postgres = { };
    };
  };
}
