{ self, ... }:
{
  flake.nixosModules.common-bundle =
    { pkgs
    , ...
    }:
    {
      imports = [
        self.nixosModules.nix
        self.nixosModules.audio
        self.nixosModules.networking
        self.nixosModules.nh
        self.nixosModules.nix-ld
        self.nixosModules.sops
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
        p7zip-rar
      ];

      services = {
        udisks2.enable = true; # Required for e-reader connections to calibre
        xserver = {
          enable = true;
          excludePackages = [ pkgs.xterm ];
        };
      };
    };
}
