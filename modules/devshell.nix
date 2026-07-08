{
  perSystem = { pkgs, ... }: {
    # nix fmt
    formatter = pkgs.nixpkgs-fmt;

    # nix develop
    devShells.default = pkgs.mkShell {
      packages = with pkgs; [
        nixfmt
        treefmt
        deadnix
        statix
        nil
      ];
    };
  };
}
