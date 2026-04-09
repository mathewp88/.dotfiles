{
  flake.homeModules.rofi =
    { osConfig
    , pkgs
    , ...
    }:
    let
      stylixColors = osConfig.lib.stylix.colors;
      stylixFonts = osConfig.stylix.fonts;
    in
    {
      home = {
        packages = [ pkgs.rofi ];

        file = {

          ".config/rofi/config.rasi".source = ./config/config.rasi;

          ".config/rofi/launch.rasi".source = ./config/launch.rasi;

          ".config/rofi/power.rasi".source = ./config/power.rasi;

          ".config/rofi/color.rasi".text = ''
            * {
                font: "${stylixFonts.monospace.name} 13";
                background:     #${stylixColors.base00};
                background-alt: #${stylixColors.base01};
                foreground:     #${stylixColors.base05};
                selected:       #${stylixColors.base03};
                active:         #${stylixColors.base0D};
                urgent:         #${stylixColors.base09};
            }
          '';
        };

      };
    };
}
