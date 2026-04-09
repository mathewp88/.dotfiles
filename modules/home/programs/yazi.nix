{ inputs, ... }:
{
  flake.homeModules.yazi =
    {
      programs.yazi = {
        enable = true;
        enableZshIntegration = true;
        shellWrapperName = "y";

        settings = {
          mgr = {
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
          chmod = "${inputs.yazi-plugins}/chmod.yazi";
          full-border = "${inputs.yazi-plugins}/full-border.yazi";
          max-preview = "${inputs.yazi-plugins}/max-preview.yazi";
        };

        initLua = ''
          			require("full-border"):setup()
          		'';

        keymap = {
          mgr.prepend_keymap = [
            {
              on = "T";
              run = "plugin max-preview";
              desc = "Maximize or restore the preview pane";
            }
            {
              on = [
                "c"
                "m"
              ];
              run = "plugin chmod";
              desc = "Chmod on selected files";
            }
          ];
        };
      };
    };
}
