{
  flake.nixosModules.networking =
    {
      networking = {
        networkmanager.enable = true;
      };
      # Enable systemd-resolved for services like tailscale, etc.
      services.resolved = {
        enable = true;
        settings.Resolve = {
          DNSSEC = "true";
          Domains = [ "~." ];
          FallbackDNS = [
            "1.1.1.1#one.one.one.one"
            "1.0.0.1#one.one.one.one"
          ];
          DNSOverTLS = "opportunistic";
        };
      };
    };
}
