{config, pkgs, lib, inputs, ... }:
{

  home.packages = with pkgs; [
    swww
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {

      "$terminal" = "wezterm";
      "$browser" = "firefox";
      "$mainMod" = "SUPER";

      exec-once = [
        "swww-daemon"
      ];

      exec = [
        "swww img ${config.stylix.image}"
      ];

      misc.disable_hyprland_logo = true;
      misc.disable_splash_rendering = true;

      bind = [
        "$mainMod, return, exec, $terminal"
        "$mainMod, I, exec, $browser"
      ];
    };
  };
}
