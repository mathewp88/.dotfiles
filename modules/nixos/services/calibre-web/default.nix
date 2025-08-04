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
  cfg = config.${namespace}.services.calibre-web;
in
{
  options.${namespace}.services.calibre-web = with types; {
    enable = mkBoolOpt false "Enable calibre-web";
  };

  config = mkIf cfg.enable {
    services.calibre-web = {
      enable = true;
      openFirewall = true;
      listen  = {
        ip = "0.0.0.0";
        port = 8083;
      };
      options = {
        calibreLibrary = "/data/calibre";
        enableBookConversion = true;
        enableBookUploading = true;
      };
    };
  };
}
