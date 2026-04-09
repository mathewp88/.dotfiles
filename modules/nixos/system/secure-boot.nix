{ inputs, ... }:
{
  flake.nixosModules.secure-boot =
    { config
    , lib
    , ...
    }:
    {
      imports = [
        inputs.lanzaboote.nixosModules.lanzaboote
      ];

      options.preferences.secure-boot.wait-for-network = lib.mkOption {
        type = lib.types.bool;
        default = false;
      };

      # Lanzaboote replaces systemd boot
      config = {
        boot = {
          loader.systemd-boot.enable = lib.mkForce false;
          initrd.systemd.network.wait-online.enable = config.preferences.secure-boot.wait-for-network;
          lanzaboote = {
            enable = true;
            pkiBundle = "/var/lib/sbctl";
          };
        };
      };
    };
}
