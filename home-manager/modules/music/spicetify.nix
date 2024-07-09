{ config, pkgs, lib, spicetify-nix, ... }:

with config.lib.stylix.colors;
let
  spicePkgs = spicetify-nix.packages.${pkgs.system}.default;
in
{
  # allow spotify to be installed if you don't have unfree enabled already
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "spotify"
  ];

  # import the flake's module for your system
  imports = [ spicetify-nix.homeManagerModule ];

  # configure spicetify :)
  programs.spicetify =
    {
      enable = true;
      # custom Dribbblish theme
      theme = spicePkgs.themes.Dribbblish;

      # specify that we want to use our custom colorscheme
      colorScheme = "custom";

      # color definition for custom color scheme. (rosepine)
      customColorScheme = {
        text = "${base0A}";
        subtext = "${base05}";
        sidebar-text = "${base05}";
        main = "${base00}";
        sidebar = "${base01}";
        player = "${base00}";
        card = "${base00}";
        shadow = "${base01}";
        selected-row = "${base03}";
        button = "${base0B}";
        button-active = "${base0F}";
        button-disabled = "${base0F}";
        tab-active = "${base0F}";
        notification = "${base0C}";
        notification-error = "${base08}";
        misc = "${base03}";
      };


      enabledExtensions = with spicePkgs.extensions; [
        fullAppDisplay
        shuffle # shuffle+ (special characters are sanitized out of ext names)
        hidePodcasts
      ];
    };
}
