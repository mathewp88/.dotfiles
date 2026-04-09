{
  flake.nixosModules.qbittorent =
    { config
    , ...
    }:
    {
      services.qbittorrent = {
        enable = true;
        inherit (config.services.jellyfin) user group;
        profileDir = "/data";
        webuiPort = 8081;
      };
    };
}
