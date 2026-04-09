{
  flake.homeModules.xdg =
    { pkgs
    , ...
    }:
    {
      xdg.portal = {
        enable = true;
        extraPortals = with pkgs; [
          xdg-desktop-portal-gtk
          xdg-desktop-portal-gnome
          xdg-desktop-portal-hyprland
        ];

        config = {
          common = {
            default = [ "gtk" ];
          };
          niri = {
            default = [ "gnome" ];
          };
          hyprland = {
            default = [
              "hyprland"
              "gtk"
            ];
          };
        };
      };
    };
}
