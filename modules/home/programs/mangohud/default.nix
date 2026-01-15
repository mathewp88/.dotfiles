{
  config,
  lib,
  libEx,
  namespace,
  ...
}:
with lib;
with libEx.${namespace};
let
  cfg = config.${namespace}.programs.mangohud;
in
{
  options.${namespace}.programs.mangohud = with types; {
    enable = mkBoolOpt false "Enable mangohud";
  };
  config = mkIf cfg.enable {
    programs.mangohud = {
      enable = true;
    };
  };
}
