{
  flake.nixosModules.jellyfin =
    { pkgs
    , ...
    }:
    {
      services.jellyfin = {
        enable = true;
        openFirewall = true;
        dataDir = "/data/jellyfin";
      };
      environment.systemPackages = with pkgs; [
        jellyfin
        jellyfin-web
        jellyfin-ffmpeg
      ];
      services.caddy.virtualHosts."jellyfin.mathai.duckdns.org".extraConfig = ''
        encode zstd gzip
        reverse_proxy localhost:8096 {
          flush_interval -1
        }
        request_body {
          max_size 5GB
        }
      '';
    };
}
