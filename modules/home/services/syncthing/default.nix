{ options
, config
, lib
, pkgs
, inputs
, namespace
, ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.services.syncthing;
in
{
  options.${namespace}.services.syncthing = with types; {
    enable = mkBoolOpt false "Enable syncthing";
  };
  config = mkIf cfg.enable {
    sops.secrets = {
      "syncthing/key" = { };
      "syncthing/cert" = { };
    };
    services.syncthing = {
      enable = true;
      key = config.sops.secrets."syncthing/key".path;
      cert = config.sops.secrets."syncthing/cert".path;
      overrideDevices = true;
      overrideFolders = true;
      settings = {
        gui.user = "mathai";
        options = {
          localAnnounceEnabled = true;
          relaysEnabled = true;
          urAccepted = -1;
        };
        devices = {
          "phone" = {
            id = "ZXNAFHS-2A5YFPF-BJHK4NT-S25VLEA-X7VLZYR-LMDRQHD-XJKAM23-ADG6KAQ";
            name = "phone";
          };
        };
        folders = {
          "KeePass" = {
            path = "/home/mathai/M/KeePass";
            devices = [ "phone" ];
            versioning = {
              type = "simple";
              params = {
                keep = "10";
              };
            };
          };
        };
      };
    };
  };
}
