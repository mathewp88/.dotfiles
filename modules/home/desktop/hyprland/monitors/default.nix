{
  config,
  lib,
  namespace,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.desktop.hyprland.monitors;
in
{
  options.${namespace}.desktop.hyprland.monitors = with types; {
    enable = mkBoolOpt false "Enable hyprland monitors";
  };
  config = mkIf cfg.enable {
    wayland.windowManager.hyprland.settings = {
      monitor = [
        "eDP-1,1920x1080@144,0x0,1"
        "HDMI-A-1,1920x1080@100,1920x0,1"
      ];

      workspace = [
        # Odd workspaces on laptop (eDP-1)
        "1, monitor:eDP-1"
        "3, monitor:eDP-1"
        "5, monitor:eDP-1"
        "7, monitor:eDP-1"
        "9, monitor:eDP-1"

        # Even workspaces on external (HDMI-A-1)
        "2, monitor:HDMI-A-1"
        "4, monitor:HDMI-A-1"
        "6, monitor:HDMI-A-1"
        "8, monitor:HDMI-A-1"
        "10, monitor:HDMI-A-1"
      ];
    };
  };
}
