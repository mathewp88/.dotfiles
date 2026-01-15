{ lib }:

let
  inherit (lib)
    filterAttrs
    mapAttrsToList
    splitString;

  homesDir = ../homes;

in
  if !builtins.pathExists homesDir then
    []
  else
    let
      systems =
        filterAttrs (_: type: type == "directory")
          (builtins.readDir homesDir);

      parseUserHost = name:
        let
          parts = splitString "@" name;
        in {
          username = builtins.elemAt parts 0;
          hostname = builtins.elemAt parts 1;
        };

      collectForSystem = system:
        mapAttrsToList
          (name: _:
            let
              parsed = parseUserHost name;
            in {
              inherit system;
              inherit (parsed) username hostname;
              path = homesDir + "/${system}/${name}/default.nix";
            }
          )
          (filterAttrs (_: type: type == "directory")
            (builtins.readDir (homesDir + "/${system}")));
    in
      builtins.concatLists
        (mapAttrsToList (system: _: collectForSystem system) systems)
