{
  flake.homeModules.office-bundle =
    { pkgs
    , ...
    }:
    {
      home.packages = with pkgs; [
        # fladder
        evince
        libreoffice
        obsidian
        signal-desktop
      ];
    };
}
