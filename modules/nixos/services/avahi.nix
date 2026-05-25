{
  flake.nixosModules.avahi = {
    services = {
      avahi = {
        enable = true;
        nssmdns4 = true;
        publish = {
          enable = true;
          addresses = true;
          domain = true;
          hinfo = true;
          workstation = true;
          userServices = true;
        };
      };
    };
  };
}
