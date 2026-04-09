{
  flake.nixosModules.stirling-pdf =
    {
      services.stirling-pdf = {
        enable = true;
        environment = {
          SERVER_PORT = 3000;
        };
      };
    };
}
