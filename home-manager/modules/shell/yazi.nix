{ pkgs, config, ... }:
let
  yazi-plugins = pkgs.fetchFromGitHub {
    owner = "yazi-rs";
    repo = "plugins";
    rev = "f202fa8969bd9c0c6ba6fb36066ae8044e73c9a7";
    hash = "sha256-oXjOLLFF2NqLfbZFvAas65zTvWQYi+Qn/mx8WpauQK0=";
  };
in
{
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    shellWrapperName = "y";

    settings = {
      manager = {
        show_hidden = true;
        show_symlink = true;
        sort_by = "natural";
      };
      preview = {
        max_width = 1000;
        max_height = 1000;
      };
    };

    plugins = {
      chmod = "${yazi-plugins}/chmod.yazi";
      full-border = "${yazi-plugins}/full-border.yazi";
      max-preview = "${yazi-plugins}/max-preview.yazi";
    };

    initLua = ''
      			require("full-border"):setup()
      		'';

    keymap = {
      manager.prepend_keymap = [
        {
          on = "T";
          run = "plugin max-preview";
          desc = "Maximize or restore the preview pane";
        }
        {
          on = [ "c" "m" ];
          run = "plugin chmod";
          desc = "Chmod on selected files";
        }
      ];
    };
  };
}
