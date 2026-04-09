{
  flake.nixosModules.thunar =
    { pkgs
    , ...
    }:
    {
      environment.systemPackages = with pkgs; [
        file-roller
      ];

      services = {
        gvfs.enable = true; # Mount, trash, and other functionalities
        tumbler.enable = true; # Thumbnail support for images
      };
      programs = {
        thunar.enable = true;
        xfconf.enable = true; # To save preferances
        thunar.plugins = with pkgs.xfce; [
          thunar-archive-plugin
          thunar-volman
        ];
      };
    };
}
