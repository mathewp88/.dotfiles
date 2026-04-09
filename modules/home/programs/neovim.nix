{
  flake.homeModules.neovim =
    { config
    , pkgs
    , lib
    , ...
    }:
    let
      linker = lib.fileContents "${pkgs.binutils}/nix-support/dynamic-linker";
    in
    {
      xdg.configFile."nvim".source =
        config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/nvim";

      home.sessionVariables = {
        EDITOR = "nvim";
      };

      programs.neovim = {
        package = pkgs.neovim-unwrapped;
        defaultEditor = true;
        enable = true;
        withRuby = true;
        withPython3 = true;
        withNodeJs = true;
        vimAlias = true;
        vimdiffAlias = true;
        viAlias = true;
        extraPackages = with pkgs; [
          rustc
          cargo
          ripgrep
          curl
          fd
          wget
          imagemagick
        ];
        # make mason and stuff work
        extraWrapperArgs = [
          "--suffix"
          "NIX_LD_LIBRARY_PATH"
          ":"
          "${lib.makeLibraryPath [
            pkgs.stdenv.cc.cc
            pkgs.zlib
          ]}"
          "--set"
          "NIX_LD"
          "${linker}"
        ];
      };
    };
}
