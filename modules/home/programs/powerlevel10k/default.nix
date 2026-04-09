{
  flake.homeModules.powerlevel10k =
    { lib
    , pkgs
    , ...
    }:
    {
      programs.zsh = {
        # below line adds the following before compInit
        initContent = lib.mkOrder 550 ''
          # p10k instant prompt
          P10K_INSTANT_PROMPT="$XDG_CACHE_HOME/p10k-instant-prompt-''${(%):-%n}.zsh"
          [[ ! -r "$P10K_INSTANT_PROMPT" ]] || source "$P10K_INSTANT_PROMPT"
        '';

        plugins = [
          {
            name = "powerlevel10k";
            src = pkgs.zsh-powerlevel10k;
            file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
          }
          {
            file = ".p10k.zsh";
            name = "powerlevel10k-config";
            src = ./config;
          }
        ];
      };
    };
}
