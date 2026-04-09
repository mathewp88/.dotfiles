{
  flake.homeModules.eza = {
    programs.eza = {
      enable = true;
      icons = "auto";

      extraOptions = [
        "--group-directories-first"
        "--icons=always"
      ];
    };
  };
}
