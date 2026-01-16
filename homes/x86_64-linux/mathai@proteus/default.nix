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
      common = enabled;
      desktop.hyprland = enabled;
      shell = enabled;
    };
    programs = {
      firefox = enabled;
      sops = lib.mkForce disabled;
      hyprlock = lib.mkForce disabled;
    };
    services.hypridle = lib.mkForce disabled;
  };

  # DO NOT MODIFY VALUE
  home.stateVersion = lib.mkDefault (osConfig.system.stateVersion or "24.05");
}
