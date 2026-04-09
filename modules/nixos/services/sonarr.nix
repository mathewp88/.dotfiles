{
  flake.nixosModules.sonarr =
    { config
    , ...
    }:
    {
      services.sonarr = {
        enable = true;
        inherit (config.services.jellyfin) user group;
        dataDir = "/data/sonarr";
      };
    };
}
