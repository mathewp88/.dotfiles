{
  flake.nixosModules.printing =
    {
      services = {
        avahi = {
          # Needed to find wireless printer
          enable = true;

          nssmdns4 = true;
          publish = {
            # Needed for detecting the scanner
            enable = true;

            addresses = true;
            userServices = true;
          };
        };
        printing = {
          enable = true;
        };
      };
    };
}
