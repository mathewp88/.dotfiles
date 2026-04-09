{
  flake.nixosModules.cloudflare-warp =
    {
      services.cloudflare-warp = {
        enable = true;
      };
    };
}
