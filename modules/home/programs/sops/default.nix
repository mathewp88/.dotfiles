{ options
, config
, lib
, pkgs
, namespace
, inputs
, ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.programs.sops;
in
{
  options.${namespace}.programs.sops = with types; {
    enable = mkBoolOpt false "Enable sops";
  };

  config = mkIf cfg.enable {
    sops = {
      age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";

      defaultSopsFile = "${inputs.nix-secrets}/secrets.yaml";
      validateSopsFiles = false;

      secrets = {
        "private_keys/victus" = {
          path = ".ssh/id_ed25519";
          mode = "0600";
        };
        "public_keys/victus" = {
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

        "weather/api" = { };

        "syncthing/key".sopsFile = "${inputs.nix-secrets}/syncthing.yaml";
        "syncthing/cert".sopsFile = "${inputs.nix-secrets}/syncthing.yaml";
      };
    };
  };
}
