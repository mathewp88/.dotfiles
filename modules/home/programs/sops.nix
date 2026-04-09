{ inputs, ... }:
{
  flake.homeModules.sops =
    { osConfig
    , config
    , ...
    }:
    {
      imports = [
        inputs.sops-nix.homeManagerModules.sops
      ];
      sops = {
        age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";

        defaultSopsFile = "${inputs.nix-secrets}/${osConfig.networking.hostName}.yaml";
        validateSopsFiles = false;

        secrets = {
          "private_keys/host" = {
            path = ".ssh/id_ed25519";
            mode = "0600";
          };
          "public_keys/host" = {
            path = ".ssh/id_ed25519.pub";
            mode = "0644";
          };

          "private_keys/github" = {
            path = ".ssh/id_github";
            mode = "0600";
          };

          "public_keys/github" = {
            path = ".ssh/id_github.pub";
            mode = "0644";
          };
        };
      };
    };
}
