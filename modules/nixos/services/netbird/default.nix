{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.services.netbird;
in
{
  options.${namespace}.services.netbird = with types; {
    enable = mkBoolOpt false "Enable netbird";
  };

  config = mkIf cfg.enable {
    services.netbird.enable = true;
  };
}
