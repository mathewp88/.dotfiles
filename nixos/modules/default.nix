{ ... }:
{
  imports = [
    ./stylix/stylix.nix
    ./hardware
    ./virualisation/docker.nix
    ./services
    ./hypr/hyprland.nix
  ];
}
