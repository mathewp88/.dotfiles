{ config
, lib
, osConfig
, namespace
, ...
}:
with lib;
with lib.${namespace};
{
  snowfallorg.user.enable = true;
  olympus = {
    bundles = {
      shell = enabled;
    };
  };

  # DO NOT MODIFY VALUE
  home.stateVersion = lib.mkDefault (osConfig.system.stateVersion or "24.05");
}
