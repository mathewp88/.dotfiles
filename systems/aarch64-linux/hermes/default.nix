{ pkgs, inputs, lib, namespace, ... }:
with lib;
with lib.${namespace};
{
  imports = [
    ./hardware.nix
    inputs.disko.nixosModules.disko
    ./disks.nix
  ];

  networking.hostName = "hermes";

  olympus = {
    bundles = {
      server = enabled;
    };
    config = {
      user = {
        name = "mathai";
        extraGroups = [
          "networkmanager"
          "wheel"
          "dialout"
        ];
      };
    };
    programs = {
      sops = enabled;
    };
  };

  environment.systemPackages = with pkgs; [ vim raspberrypifw git neovim nh tmux ];

  boot.kernelPackages = pkgs.linuxKernel.packages.linux_rpi4;
  # DO NOT MODIFY VALUE
  system.stateVersion = "23.11";
}
