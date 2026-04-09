{
  flake.homeModules.desktopEntries =
    { config
    , ...
    }:
    let
      terminalChoice =
        if config.programs.kitty.enable then
          "kitty"
        else if config.programs.ghostty.enable then
          "ghostty"
        else
          "xterm"; # fallback
    in
    {
      xdg = {
        enable = true;
        userDirs.enable = true;
        desktopEntries."nvim" = {
          name = "Neovim";
          comment = "Edit text files";
          exec = "${terminalChoice} -e nvim %F";
          icon = "nvim";
          terminal = false;
          type = "Application";
          categories = [
            "Utility"
            "TextEditor"
          ];
        };
      };
    };
}
