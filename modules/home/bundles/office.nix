{
  flake.homeModules.office-bundle =
    { pkgs
    , ...
    }:
    {
      home.packages = with pkgs; [
        tsukimi
        evince
        libreoffice
        obsidian
        signal-desktop
      ];
    };
}
