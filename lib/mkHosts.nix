{ nixpkgs, home-manager, inputs }:

let
  lib = nixpkgs.lib;
  hostsDir = ../systems;

  homes =
    import ./mkHomes.nix {
      lib = nixpkgs.lib;
    };

  mkHost = system: hostname:
    let
      matchingHomes =
        builtins.filter
          (h:
            h.system == system &&
            h.hostname == hostname)
          homes;

      hmUsers =
        builtins.listToAttrs (
          map (h: {
            name = h.username;
            value = import h.path;
          }) matchingHomes
        );
    in
      lib.nixosSystem {
        inherit system;

        modules =
          builtins.attrValues inputs.self.nixosModules
          ++ inputs.self.nixosInputs
          ++ [
            {
              nixpkgs.config.allowUnfree = true;

              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;

              home-manager.sharedModules =
                builtins.attrValues inputs.self.homeModules
                ++ inputs.self.homeInputs;

              home-manager.extraSpecialArgs = {
                libEx = inputs.self.lib;
                namespace = inputs.self.namespace;
                inputs = inputs;
              };

              home-manager.users = hmUsers;
            }

            home-manager.nixosModules.home-manager
            (hostsDir + "/${system}/${hostname}/default.nix")
          ];

        specialArgs = {
          lib = inputs.self.lib;
          namespace = inputs.self.namespace;
          inherit inputs;
        };
      };

  # discover hosts (unchanged)
  systems =
    builtins.attrNames
      (builtins.readDir hostsDir);

  hostsForSystem = system:
    builtins.attrNames
      (builtins.readDir (hostsDir + "/${system}"));

in
  builtins.listToAttrs (
    builtins.concatMap
      (system:
        map
          (hostname: {
            name = hostname;
            value = mkHost system hostname;
          })
          (hostsForSystem system)
      )
      systems
  )

