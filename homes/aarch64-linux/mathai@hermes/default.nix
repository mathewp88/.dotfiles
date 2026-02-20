{
  lib,
  libEx,
  osConfig,
  namespace,
  ...
}:
with lib;
with libEx.${namespace};
{
  olympus = {
    bundles = {
      shell = enabled;
    };
    programs = {
      sops = enabled;
    };
    services = {
      ssh = enabled;
    };
  };

  # DO NOT MODIFY VALUE
  home.stateVersion = lib.mkDefault (osConfig.system.stateVersion or "24.05");
}
