{
  flake.nixosModules.security = {
    # Enable security levels for Thunderbolt 3 on GNU/Linux.
    services.hardware.bolt.enable = true;

    networking.firewall.enable = true;

    security = {
      rtkit.enable = true;
    };
  };
}
