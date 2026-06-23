{
  flake.nixosModules.hostProteusHardware =
    { lib
    , modulesPath
    , ...
    }:
    {
      imports = [
        (modulesPath + "/profiles/qemu-guest.nix")
      ];

      boot = {
        # build-vm does not use the bootloader, but systemd-boot keeps the
        # configuration valid if this host is ever installed to a real disk.
        loader = {
          systemd-boot = {
            enable = true;
            editor = false;
          };
          efi.canTouchEfiVariables = true;
        };
        initrd = {
          availableKernelModules = [
            "virtio_net"
            "virtio_scsi"
            "virtio_blk"
            "virtio_pci"
            "virtio_rng"
            "9p"
            "9pnet_virtio"
          ];
          kernelModules = [ ];
        };
        kernelModules = [ ];
        extraModulePackages = [ ];
      };

      fileSystems = {
        "/" = {
          device = "/dev/disk/by-label/nixos";
          fsType = "ext4";
          autoResize = true;
        };
        "/boot" = {
          device = "/dev/disk/by-label/boot";
          fsType = "vfat";
          options = [
            "fmask=0022"
            "dmask=0022"
          ];
        };
      };

      networking.useDHCP = lib.mkDefault true;

      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
      hardware.enableRedistributableFirmware = true;
    };
}
