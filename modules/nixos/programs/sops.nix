{ inputs, ... }:
{
  flake.nixosModules.sops =
    { config
    , pkgs
    , ...
    }:
    {
      imports = [
        inputs.sops-nix.nixosModules.sops
      ];
      environment.systemPackages = with pkgs; [
        age
        sops
        ssh-to-age
      ];

      sops = {
        defaultSopsFile = "${inputs.nix-secrets}/${config.networking.hostName}.yaml";
        validateSopsFiles = false;

        age = {
          sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
          keyFile = "/var/lib/sops-nix/key.txt";
          generateKey = true;
        };
      };

    };
}
