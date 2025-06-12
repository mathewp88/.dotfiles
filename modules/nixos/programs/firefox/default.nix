{ config
, lib
, namespace
, ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.programs.firefox;
in
{
  options.${namespace}.programs.firefox = {
    enable = mkBoolOpt false "Enable Firefox";
  };

  config = mkIf cfg.enable {

    home.sessionVariables = {
      BROWSER = "firefox";
    };

    programs.firefox = {
      enable = true;
      package = pkgs.librewolf;
    };
  };
}
