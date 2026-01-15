{ nixpkgs, namespace }:

let
  base = nixpkgs.lib;
  custom = import ./helpers.nix { lib = base; };
in
  base // {
    ${namespace} = custom;
  }
