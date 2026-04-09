{
  flake.homeModules.keepassxc =
    {
      programs.keepassxc = {
        enable = true;
        settings = {
          Browser.Enabled = true;
          GUI = {
            ApplicationTheme = "classic";
            CompactMode = false;
            TrayIconAppearance = "monochrome-light";
          };
          PasswordGenerator.Length = 32;
        };
      };
    };
}
