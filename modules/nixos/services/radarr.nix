{
  flake.nixosModules.radarr =
    { config
    , ...
    }:
    {
      services.radarr = {
        enable = true;
        inherit (config.services.jellyfin) user group;
        dataDir = "/data/radarr";
      };
    };
}
