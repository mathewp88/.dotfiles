{ self, ... }:
{
  flake.nixosModules.server-bundle =
    { pkgs
    , ...
    }:
    {
      imports = [
        self.nixosModules.nix
        self.nixosModules.networking
        self.nixosModules.nh
        self.nixosModules.nix-ld
        self.nixosModules.fail2ban
        self.nixosModules.security
        self.nixosModules.openssh
        self.nixosModules.fonts
        self.nixosModules.locale
      ];
      environment.systemPackages = with pkgs; [
        wget
        curl
        git
        fastfetch
      ];

      services = {
        udisks2.enable = true; # Required for e-reader connections to calibre
      };

      preferences.openssh.passwordAuth = true;
    };
}
