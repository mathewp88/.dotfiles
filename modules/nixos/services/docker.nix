{
  flake.nixosModules.docker =
    { config
    , pkgs
    , ...
    }:
    {
      environment.systemPackages = with pkgs; [ xhost ];
      virtualisation.docker = {
        enable = true;
        storageDriver = if (config.fileSystems."/".fsType == "btrfs") then "btrfs" else "overlay2";
        rootless = {
          enable = true;
          setSocketVariable = true;
          daemon.settings = {
            features.cdi = true;
            "dns" = [
              "8.8.8.8"
              "1.1.1.1"
            ];
          };
        };
      };
      hardware.nvidia-container-toolkit.enable = builtins.any
        (
          driver: driver == "nvidia"
        )
        config.services.xserver.videoDrivers;
    };
}
