{
  flake.homeModules.ludusavi =
    {
      services.ludusavi = {
        enable = true;
        frequency = "daily";
        backupNotification = true;

        settings = {
          backup = {
            path = "~/Games/ludusavi-backup/";
          };
          language = "en-US";
          restore = {
            path = "~/Games/ludusavi-backup/";
          };
          roots = [
            {
              path = "~/.local/share/Steam";
              store = "steam";
            }
            {
              path = "~/.local/share/lutris";
              store = "lutris";
            }
          ];
          theme = "dark";
        };
      };
    };
}
