{
  inputs,
  lib,
  self,
  ...
}:
{
  flake.nixosConfigurations.proteus = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.hostProteus
    ];
  };

  flake.nixosModules.hostProteus =
    {
      pkgs,
      ...
    }:
    {
      imports = [
        inputs.home-manager.nixosModules.default

        self.nixosModules.hostProteusHardware

        # Core system modules. Common-bundle pulls in the sops module so its
        # options exist for type-checking, but no secrets are declared on this
        # host (useSopsPassword = false below) so nothing is decrypted.
        self.nixosModules.common-bundle
        self.nixosModules.user

        # Desktop
        self.nixosModules.hyprland
        self.nixosModules.plymouth
        self.nixosModules.stylix
      ];

      preferences = {
        user = {
          name = "mathai";
          extraGroups = [
            "networkmanager"
            "wheel"
          ];
          # Plain password so the VM is testable without sops
          password = "proteus";
          useSopsPassword = false;
        };
        openssh.passwordAuth = true;
      };

      environment.systemPackages = with pkgs; [
        wget
        curl
        git
        fastfetch
      ];

      services = {
        udisks2.enable = true;
        xserver = {
          enable = true;
          excludePackages = [ pkgs.xterm ];
        };
        # Auto-login the test user for convenience
        getty.autologinUser = lib.mkForce "mathai";
        displayManager = {
          autoLogin = {
            enable = true;
            user = "mathai";
          };
          sddm.autoLogin.relogin = true;
        };
      };

      home-manager = {
        users.mathai = self.homeModules.mathai-proteus;
        useUserPackages = true;
        useGlobalPkgs = true;
      };

      networking.hostName = "proteus";
      system.stateVersion = "24.05";

      # VM-friendly settings used by `nixos-rebuild build-vm`
      virtualisation.vmVariant = {
        virtualisation = {
          memorySize = 4096;
          cores = 4;
          graphics = true;
        };
      };
    };
}
