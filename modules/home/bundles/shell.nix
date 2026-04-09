{ self, ... }:
{
  flake.homeModules.shell-bundle =
    { pkgs
    , ...
    }:
    {
      imports = [
        self.homeModules.bat
        self.homeModules.eza
        self.homeModules.fzf
        self.homeModules.git
        self.homeModules.lazygit
        self.homeModules.neovim
        self.homeModules.powerlevel10k
        self.homeModules.tmux
        self.homeModules.zoxide
        self.homeModules.zsh
      ];
      home.packages = with pkgs; [
        # Terminal
        bottom
        coreutils
        gcc
        killall
        wget
        ncdu
        duf
        which
        trash-cli
        tealdeer
        ripgrep
        fd
        aria2

        # archives
        zip
        xz
        unzip

        # system tools
        sysstat
        lm_sensors # for `sensors` command
        ethtool
        pciutils # lspci
        usbutils # lsusb
        nmap # network scanning
      ];
    };
}
