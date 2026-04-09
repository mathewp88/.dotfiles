{
  flake.nixosModules.systemd-boot =
    { config, lib, ... }:
    {
      options.preferences.boot.wait-for-network = lib.mkOption {
        type = lib.types.bool;
        default = false;
      };

      config = {
        boot = {
          initrd.systemd.network.wait-online.enable = config.preferences.boot.wait-for-network;
          loader = {
            systemd-boot = {
              enable = true;
              editor = false;
            };

            efi.canTouchEfiVariables = true;
            timeout = 5;
          };
        };
      };
    };
}
