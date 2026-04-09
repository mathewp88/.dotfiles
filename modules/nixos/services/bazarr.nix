{
  flake.nixosModules.bazarr =
    { config
    , ...
    }:
    {
      services.bazarr = {
        enable = true;
        inherit (config.services.jellyfin) user group;
        dataDir = "/data/bazarr";
      };
    };
}
