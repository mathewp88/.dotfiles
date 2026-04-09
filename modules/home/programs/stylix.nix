{
  flake.homeModules.stylix =
    { pkgs
    , config
    , ...
    }:
    {
      home.packages = [ pkgs.papirus-icon-theme ];
      gtk.gtk4.theme = config.gtk.theme;
      gtk.iconTheme.name = "Papirus-Dark";
      stylix = {
        enable = true;
        autoEnable = true;
        icons = {
          enable = true;
          package = pkgs.papirus-icon-theme;
          light = "Papirus-Light";
          dark = "Papirus-Dark";
        };
        targets = {
          firefox = {
            colorTheme.enable = true;
            profileNames = [ "default" ];
          };
          ghostty.enable = false;
          kitty.enable = false;
          waybar.enable = false;
          hyprlock.enable = false;
          neovim.enable = false;
          neovide.enable = false;
          tmux.enable = false;
        };
      };
    };
}
