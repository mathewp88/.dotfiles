{
  lib,
  namespace,
  ...
}:
with lib;
with lib.${namespace};
{
  networking.hostName = "ares";

  olympus = {
    config = {
      nix = enabled;
      user = {
        name = "mathai";
        extraGroups = [
          "networkmanager"
          "wheel"
        ];
        password = "mathai";
      };
    };


    hardware = {
      audio = enabled;
      networking = enabled;
    };

    programs = {
      nh = enabled;
      nix-ld = enabled;
      stylix = enabled;
    };

    services = {
      security = enabled;
    };

    desktop.hyprland = enabled;

    system = {
        fonts = enabled;
        locale = enabled;
      boot.systemd-boot = {
        enable = true;
        wait-for-network = false;
      };
    };
  };

  # --- VM Guest Services ---
  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;

  # --- The "build-vm" Configuration Block ---
  # These settings apply ONLY when you run 'nixos-rebuild build-vm'
  virtualisation.vmVariant = {
    virtualisation = {
      memorySize = 4096; # MiB
      cores = 4;
      graphics = true;
    };
  };

  nixpkgs.config.allowUnfree = true;
  # DO NOT MODIFY VALUE
  system.stateVersion = "24.05";
}
