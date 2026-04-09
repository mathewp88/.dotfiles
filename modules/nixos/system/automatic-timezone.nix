{
  flake.nixosModules.automatic-timezone =
    {
      services.automatic-timezoned.enable = true;
    };
}
