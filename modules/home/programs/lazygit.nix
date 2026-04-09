{
  flake.homeModules.lazygit =
    { config
    , lib
    , ...
    }:
    let
      stylixEnabled = config.programs.stylix.enable or false;

      accent = if stylixEnabled then "#${config.lib.stylix.colors.base0D}" else null;
      muted = if stylixEnabled then "#${config.lib.stylix.colors.base03}" else null;
      selected = if stylixEnabled then "#${config.lib.stylix.colors.base02}" else null;
    in
    {
      programs.lazygit = {
        enable = true;
        settings = lib.mkForce {
          gui = {
            theme = lib.mkIf stylixEnabled {
              activeBorderColor = [
                accent
                "bold"
              ];
              inactiveBorderColor = [ muted ];
              selectedLineBgColor = [ selected ];
            };
            showListFooter = false;
            showRandomTip = false;
            showCommandLog = false;
            showBottomLine = false;
            nerdFontsVersion = "3";
          };
        };
      };
    };
}
