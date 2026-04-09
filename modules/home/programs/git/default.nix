{
  flake.homeModules.git =
    {
      programs.git = {
        enable = true;
        lfs.enable = true;
      };
      programs.delta = {
        enable = true;
        enableGitIntegration = true;
      };
      home.file.".gitconfig".source = ./.gitconfig;
    };
}
