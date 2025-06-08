{ options
, config
, osConfig
, lib
, pkgs
, inputs
, namespace
, ...
}:
with lib;
with lib.${namespace};
with osConfig.lib.stylix.colors;
let
  cfg = config.${namespace}.programs.rofi;
in
{
  options.${namespace}.programs.rofi = with types; {
    enable = mkBoolOpt false "Enable rofi";
  };
  config = mkIf cfg.enable {

    home.packages = [ pkgs.rofi-wayland ];

    home.file.".config/rofi/config.rasi".source = ./config/config.rasi;

    home.file.".config/rofi/launch.rasi".source = ./config/launch.rasi;

    home.file.".config/rofi/power.rasi".source = ./config/power.rasi;

    home.file.".config/rofi/color.rasi".text = ''
      * {
          font: "JetBrains Mono Nerd Font 13";
          background:     #${base00};
          background-alt: #${base01};
          foreground:     #${base05};
          selected:       #${base03};
          active:         #${base0D};
          urgent:         #${base09};
      }
    '';

  };
}
