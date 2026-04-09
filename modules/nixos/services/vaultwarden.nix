{
  flake.nixosModules.vaultwarden =
    { config
    , ...
    }:
    {
      services.vaultwarden = {
        enable = true;
        backupDir = "/data/vaultwarden";
        config = {
          DOMAIN = "https://vault.mathai.duckdns.org";
          SIGNUPS_ALLOWED = false;

          ROCKET_ADDRESS = "127.0.0.1";
          ROCKET_PORT = 8222;
          ROCKET_LOG = "critical";
        };
      };
      services.caddy.virtualHosts."vault.mathai.duckdns.org".extraConfig = ''
        encode zstd gzip
        reverse_proxy localhost:${toString config.services.vaultwarden.config.ROCKET_PORT} {
          header_up X-Real-IP {remote_host}
        }
      '';
    };
}
