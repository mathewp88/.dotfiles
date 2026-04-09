{
  flake.nixosModules.tailscale =
    { config
    , ...
    }:
    {
      sops.secrets = {
        tailscale = { };
      };
      services.tailscale = {
        enable = true;
        authKeyFile = config.sops.secrets.tailscale.path;
      };
    };
}
