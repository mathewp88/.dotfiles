{
  flake.nixosModules.openssh =
    { lib
    , config
    , ...
    }:
    {
      options.preferences.openssh.passwordAuth = lib.mkOption {
        type = lib.types.bool;
        default = false;
      };

      config = {
        services.openssh = {
          enable = true;
          settings = {
            X11Forwarding = true;
            PermitRootLogin = "no";
            PasswordAuthentication = config.preferences.openssh.passwordAuth;
          };
        };
      };
    };
}
