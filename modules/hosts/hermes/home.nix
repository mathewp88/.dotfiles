{ self, ... }:
{
  flake.homeModules.mathai-hermes = {
    imports = [
      self.homeModules.shell-bundle

      self.homeModules.sops

      self.homeModules.ssh
    ];
    home.stateVersion = "24.05";
  };
}
