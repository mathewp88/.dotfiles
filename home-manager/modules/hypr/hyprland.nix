{ pkgs, lib, inputs, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
  };
}
