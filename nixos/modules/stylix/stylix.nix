{ config, pkgs, ... }:
{
  stylix.enable = true;
  stylix.autoEnable = true;
  stylix.image = ./cherry.png;
  stylix.polarity = "dark";
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine.yaml";
  stylix.fonts.sizes.applications = 10;
  stylix.fonts.sizes.desktop = 10;
  stylix.fonts.sizes.popups = 10;
  stylix.cursor.package = pkgs.bibata-cursors;
  stylix.cursor.name = "Bibata-Modern-Classic";
  stylix.cursor.size = 24;
}
