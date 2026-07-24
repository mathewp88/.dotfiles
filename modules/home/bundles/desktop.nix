{ self, ... }:
{
  flake.homeModules.desktop-bundle = {
    imports = [
      self.homeModules.noctalia
      self.homeModules.swayosd
      self.homeModules.xdg
    ];
  };
}
