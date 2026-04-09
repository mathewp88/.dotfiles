{
  flake.nixosModules.gdm =
    {
      services.displayManager.gdm = {
        enable = true;
        wayland = true;
      };
    };
}
