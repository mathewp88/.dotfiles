{ options, config, lib, pkgs, namespace, ... }:
with lib;
with lib.${namespace};
let cfg = config.${namespace}.services.tailscale;
in
{
  options.${namespace}.services.tailscale = with types; {
    enable = mkBoolOpt false "Enable tailscale";
  };

  config = mkIf cfg.enable {
    sops.secrets = { tailscale = { }; };
    services.tailscale = {
      enable = true;
      openFirewall = true;
      authKeyFile = config.sops.secrets.tailscale.path;
    };
  };
}
