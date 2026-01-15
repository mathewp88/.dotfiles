{
  config,
  pkgs,
  lib,
  libEx,
  namespace,
  ...
}:
with lib;
with libEx.${namespace};
let
  cfg = config.${namespace}.programs.zed;
in
{
  options.${namespace}.programs.zed = {
    enable = mkBoolOpt false "${namespace}.programs.zed.enable";
  };
  config = mkIf cfg.enable {

    # home.sessionVariables = {
    #   EDITOR = "zeditor --wait";
    # };

    programs.zed-editor = {
      enable = true;
      mutableUserSettings = true;
      userSettings = builtins.fromJSON (builtins.readFile ./settings.json) // {
        ui_font_size = lib.mkForce 18.5;
        buffer_font_size = lib.mkForce 18.0;
        theme = lib.mkForce "Rosé Pine";
      };
      userTasks = builtins.fromJSON (builtins.readFile ./tasks.json);
      userKeymaps = builtins.fromJSON (builtins.readFile ./keymaps.json);
      extraPackages = with pkgs; [
        bat
        fd
        nixd
        nil
        lazygit
        television
      ];
    };
  };
}
