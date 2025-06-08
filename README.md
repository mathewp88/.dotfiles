# Olympus NixOS Config

For testing:
sh```
sudo nixos-rebuild dry-activate --flake .#hostname
```

if using .nix-secrets:
sh```
sudo --preserve-env=SSH_AUTH_SOCK nixos-rebuild dry-activate --flake .#ares
```
## Replace dry-activate with switch to actually use.
