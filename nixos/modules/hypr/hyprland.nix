{ lib, pkgs, config, ... }:
let
  sddm-astronaut = pkgs.sddm-astronaut.override {
    themeConfig = {
      FormPosition = "center";
      FullBlur = true;
      AccentColor = "#${config.lib.stylix.colors.base05}";
      TextColor = "#${config.lib.stylix.colors.base05}";
      PlaceholderColor = "#${config.lib.stylix.colors.base05}";
      SystemButtonsIconColor = "#${config.lib.stylix.colors.base05}";
      HighlightColor = "#${config.lib.stylix.colors.base05}";
      Font = "JetBrains Mono Nerd Font Mono";
      Background = "${config.stylix.image}";
      ForceHideCompletePassword = true;
    };
  };
in
{

  services.displayManager.sddm = {
    enable = true;
    package = pkgs.kdePackages.sddm; # qt6 sddm version
    theme = "sddm-astronaut-theme";
    extraPackages = [ sddm-astronaut ];
    wayland.enable = true;
  };

  services.xserver.desktopManager.gnome.enable = false;
  environment.gnome.excludePackages = (with pkgs; [
    gnome-tour
    gnome-music
    nautilus
    gnome-terminal
    epiphany
    geary
    gnome-characters
  ]);

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  xdg.portal.enable = true;
  #xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  services.gnome.gnome-keyring.enable = true;
  security.pam.services.gdm.enableGnomeKeyring = true;
  security.pam.services.gdm-password.enableGnomeKeyring = true;

  security.pam.services.hyprlock.text = lib.readFile "${pkgs.hyprlock}/etc/pam.d/hyprlock";

  environment.systemPackages = with pkgs; [
    sddm-astronaut
    polkit_gnome # For auth in wm
    nemo-with-extensions
  ];
}
