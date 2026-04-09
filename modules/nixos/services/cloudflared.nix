{
  flake.nixosModules.clourflared =
    { config
    , ...
    }:
    {
      sops.secrets = {
        "cloudflared/cert" = { };
        "cloudflared/immich" = { };
      };
      services.cloudflared = {
        enable = true;
        certificateFile = config.sops.secrets."cloudflared/cert".path;
        tunnels = {
          "b639bfb3-d848-41f8-af2b-6a77bc5ade5d" = {
            credentialsFile = config.sops.secrets."cloudflared/immich".path;
            default = "http_status:404";
            ingress = {
              "mathai.duckdns.org" = "http://localhost:2283";
            };
          };
        };
      };
    };
}
