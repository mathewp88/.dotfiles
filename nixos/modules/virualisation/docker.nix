{ config, ... }:
{
  virtualisation.docker = {
    enable = true;
    storageDriver = "btrfs";
    enableNvidia = builtins.any (driver: driver == "nvidia") config.services.xserver.videoDrivers;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };
}
