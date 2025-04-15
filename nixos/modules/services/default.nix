{config, ... }:
{
  imports = [
    ./daemon.nix
    ./pipewire.nix
    ./wine.nix
    ./syncthing.nix
    ./sops.nix
  ];
}
