{ config, lib, pkgs, ... }:

let
  linker = lib.fileContents "${pkgs.binutils}/nix-support/dynamic-linker";
in
{
  stylix.targets.neovim.enable = false;
  
  home.file."${config.home.homeDirectory}/.config/nvim".source = 
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/nvim";

  programs.lazygit.enable = true;

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
      python311
      devpod
      rustc
      cargo
      wl-clipboard
      ripgrep
      bottom
      curl
      fd
      wget
    ];
    extraWrapperArgs = [
      "--suffix"
      "NIX_LD_LIBRARY_PATH"
      ":"
      "${lib.makeLibraryPath [pkgs.stdenv.cc.cc pkgs.zlib]}"
      "--set"
      "NIX_LD"
      "${linker}"
    ];
  };
}
