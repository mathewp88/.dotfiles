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

        # Volume
        ",0x1008FF11,exec,wpctl set-volume @DEFAULT_SINK@ 5%-"
        ",0x1008FF13,exec,wpctl set-volume @DEFAULT_SINK@ 5%+"
        ",0x1008FF12,exec,wpctl set-mute @DEFAULT_SINK@ toggle"
        ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_SOURCE@ toggle"

        # Brightness
        ",XF86MonBrightnessUp,exec,brightnessctl s +5%"
        ",XF86MonBrightnessDown,exec,brightnessctl s 5%-"

        # Windows
        "$mainMod, J, movefocus, d"
        "$mainMod, K, movefocus, u"
        "$mainMod, H, movefocus, l"
        "$mainMod, L, movefocus, r"
        "SUPER_SHIFT,J,movewindow,d"
        "SUPER_SHIFT,K,movewindow,u"
        "SUPER_SHIFT,H,movewindow,l"
        "SUPER_SHIFT,L,movewindow,r"
        "$mainMod, S, togglespecialworkspace, magic"
        "$mainMod SHIFT, S, movetoworkspace, special:magic"
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"
      ] ++ (
        # workspaces
        # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
        builtins.concatLists (builtins.genList (
          x: let
            ws = let
              c = (x + 1) / 10;
            in
              builtins.toString (x + 1 - (c * 10));
          in [
            "$mainMod, ${ws}, workspace, ${toString (x + 1)}"
            "$mainMod SHIFT, ${ws}, movetoworkspacesilent, ${toString (x + 1)}"
          ]
        )
          10)
      );
       
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
    };
  };
}
