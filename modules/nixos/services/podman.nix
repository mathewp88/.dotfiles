{
  flake.nixosModules.podman =
    { config
    , pkgs
    , ...
    }:
    {
      virtualisation.containers.enable = true;
      virtualisation.podman = {
        enable = true;
        dockerCompat = true;
        defaultNetwork.settings.dns_enabled = true;
      };
      environment.systemPackages = with pkgs; [ podman-compose ];

      hardware.nvidia-container-toolkit.enable = builtins.any
        (
          driver: driver == "nvidia"
        )
        config.services.xserver.videoDrivers;
    };
}
