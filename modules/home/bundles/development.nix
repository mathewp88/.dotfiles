{ self, ... }:
{
  flake.homeModules.development-bundle =
    {
      pkgs,
      ...
    }:
    {
      imports = [
        self.homeModules.atuin
        self.homeModules.direnv
      ];

      home.packages = with pkgs; [
        caligula
        nvitop
        planify
        gh

        gemini-cli
        codex
        pi-coding-agent

        # python
        uv

        # Notes
        obsidian
        zotero

        # robotics
        arduino-cli
        minicom
      ];

    };
}
