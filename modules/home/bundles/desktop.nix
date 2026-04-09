{ self, ... }:
{
  flake.homeModules.desktop-bundle =
    {
      imports = [
        self.homeModules.noctalia
        self.homeModules.xdg
      ];
    };
}
