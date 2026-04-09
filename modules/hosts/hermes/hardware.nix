{
  flake.nixosModules.hostHermes =
    { lib
    , modulesPath
    , ...
    }:
    {
      imports = [
        (modulesPath + "/installer/scan/not-detected.nix")
      ];

      boot = {
        loader = {
          grub.enable = false;
          generic-extlinux-compatible.enable = true;
        };
        initrd.availableKernelModules = [
          "xhci_pci"
          "usbhid"
          "usb_storage"
        ];
        kernelParams = [
          "8250.nr_uarts=1"
          "console=tyAMA0,115200"
          "console=tty1"
          "cma=128M"
        ];
        initrd.kernelModules = [ ];
        kernelModules = [ ];
        extraModulePackages = [ ];
      };

      networking.useDHCP = lib.mkDefault true;

      nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
      hardware.enableRedistributableFirmware = true;
    };
}
