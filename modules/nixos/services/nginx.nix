{
  flake.nixosModules.nginx =
    { config
    , ...
    }:
    {
      sops.secrets = {
        "duckdns-token" = { };
      };

      services.nginx = {
        enable = true;
        recommendedGzipSettings = true;
        recommendedOptimisation = true;
        recommendedProxySettings = true;
        recommendedTlsSettings = true;
      };

      networking.firewall.allowedTCPPorts = [
        80
        443
      ];

      security.acme = {
        acceptTerms = true;
        defaults.email = "ssl@mathai.duckdns.org";

        certs."mathai.duckdns.org" = {
          domain = "mathai.duckdns.org";
          extraDomainNames = [ "*.mathai.duckdns.org" ];
          dnsProvider = "duckdns";
          dnsPropagationCheck = true;
          credentialsFile = config.sops.secrets."duckdns-token".path;
        };
      };

      users.users.nginx.extraGroups = [ "acme" ];
    };
}
