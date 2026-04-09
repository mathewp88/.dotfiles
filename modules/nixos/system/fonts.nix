{
  flake.nixosModules.fonts =
    { pkgs
    , ...
    }:
    {
      fonts = {
        enableDefaultPackages = true;
        packages = with pkgs; [
          nerd-fonts.jetbrains-mono
          nerd-fonts.fira-code
          meslo-lgs-nf
          noto-fonts
          roboto
          corefonts
        ];
      };
    };
}
