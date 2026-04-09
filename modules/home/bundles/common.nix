{ self, ... }:
{
  flake.homeModules.common-bundle =
    { pkgs
    , ...
    }:
    {
      imports = [
        self.homeModules.desktopEntries
        self.homeModules.ghostty
        self.homeModules.sops
        self.homeModules.stylix
        self.homeModules.zed
        self.homeModules.ssh
      ];
      home.packages = with pkgs; [
        # Video/Audio
        vlc
        loupe
        pavucontrol
      ];
    };
}
