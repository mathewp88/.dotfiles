{
  flake.nixosModules.bluetooth =
    { pkgs
    , ...
    }:
    {
      hardware.bluetooth = {
        enable = true;
        package = pkgs.bluez;
        powerOnBoot = true;
        settings = {
          General = {
            Experimental = true;
          };
        };
      };

      services.blueman.enable = true;
    };
}
