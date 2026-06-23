{ self, ... }:
{
  flake.homeModules.mathai-proteus = {
    imports = [
      # Mirrors common-bundle minus sops
      self.homeModules.desktopEntries
      self.homeModules.ghostty
      self.homeModules.stylix

      self.homeModules.desktop-bundle
      self.homeModules.shell-bundle

      self.homeModules.hyprland
      self.homeModules.firefox
    ];
    home.stateVersion = "24.05";
  };
}
