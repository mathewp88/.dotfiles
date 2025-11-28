{
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.bundles.common;
in
{
  options.${namespace}.bundles.common = with types; {
    enable = mkBoolOpt false "Whether or not to enable common configuration.";
  };

  config = mkIf cfg.enable {

    environment.systemPackages = with pkgs; [
      wget
      curl
      git
      fastfetch
      p7zip-rar
    ];

    services = {
      udisks2.enable = true; # Required for e-reader connections to calibre
      xserver = {
        enable = true;
        excludePackages = [ pkgs.xterm ];
      };
    };

    olympus = {
      config.nix = enabled;

      hardware = {
        audio = enabled;
        networking = enabled;
      };

      programs = {
        nh = enabled;
        nix-ld = enabled;
        sops = enabled;
      };

      services = {
        security = enabled;
        ssh = enabled;
      };

      system = {
        fonts = enabled;
        locale = enabled;
      };
    };
  };
}
