{
  flake.nixosModules.user =
    { config
    , lib
    , pkgs
    , ...
    }:
    let
      cfg = config.preferences.user;
    in
    {
      options.preferences.user = {
        name = lib.mkOption {
          type = lib.types.str;
          default = "mathai";
        };

        fullName = lib.mkOption {
          type = lib.types.str;
          default = "Mathai Mathew";
        };

        email = lib.mkOption {
          type = lib.types.str;
          default = "mathewp8616@gmail.com";
        };

        extraGroups = lib.mkOption {
          type = lib.types.listOf lib.types.str;
          default = [ ];
        };

        extraOptions = lib.mkOption {
          type = lib.types.attrs;
          default = { };
        };

        sshKeys = lib.mkOption {
          type = lib.types.listOf lib.types.str;
          default = [ ];
        };

        password = lib.mkOption {
          type = lib.types.nullOr lib.types.str;
          default = null;
        };
      };

      config = lib.mkMerge [
        {
          programs.zsh.enable = true;

          users.users.${cfg.name} = {
            isNormalUser = true;
            createHome = true;
            home = "/home/${cfg.name}";
            group = "users";
            shell = pkgs.zsh;
            uid = 1000;
            inherit (cfg) extraGroups;
            openssh.authorizedKeys.keys = cfg.sshKeys;
            password = lib.mkIf (cfg.password != null) cfg.password;
          }
          // cfg.extraOptions;
        }

        (lib.mkIf (config.sops.defaultSopsFile != null) {
          sops.secrets."${cfg.name}-password".neededForUsers = true;
          sops.secrets."root-password".neededForUsers = true;

          users = {
            mutableUsers = false;
            users.${cfg.name}.hashedPasswordFile = config.sops.secrets."${cfg.name}-password".path;
            users.root.hashedPasswordFile = config.sops.secrets."root-password".path;
          };
        })
      ];
    };
}
