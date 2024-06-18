{ config, pkgs, ... }:
{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  kernelPackages = pkgs.linuxPackages_latest;

  imports = [ ./nvidia.nix ];

  hardware = {
    # Enable all firmware regardless of license.
    enableAllFirmware = true;

    # Enable firmware with a license allowing redistribution.
    enableRedistributableFirmware = true;

    # update the CPU microcode for Intel processors.
    cpu.amd.updateMicrocode = true;

    # Enable OpenGL drivers
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
  };

}
