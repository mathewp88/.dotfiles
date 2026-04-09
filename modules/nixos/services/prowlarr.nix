{
  flake.nixosModules.prowlarr =
    { config
    , lib
    , pkgs
    , ...
    }:
    let
      dataDir = "/data/prowlarr";
    in
    {
      environment.systemPackages = with pkgs; [
        prowlarr
        dotnetCorePackages.aspnetcore_8_0
      ];

      systemd = {
        services.prowlarr = {
          description = "Prowlarr";
          after = [ "network.target" ];
          wantedBy = [ "multi-user.target" ];

          serviceConfig = {
            Type = "simple";
            User = config.services.jellyfin.user;
            Group = config.services.jellyfin.group;
            ExecStart = "${lib.getExe pkgs.prowlarr} -nobrowser -data=${dataDir}";
            Restart = "on-failure";
          };
        };
      };
      services.flaresolverr = {
        enable = true;
      };
    };
}
