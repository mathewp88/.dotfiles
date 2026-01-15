{ lib }:

let
  inherit (lib)
    mapAttrsToList
    listToAttrs
    filterAttrs;

  modulesDir = ../modules/nixos;

  collect =
    dir: prefix:
      let
        entries = builtins.readDir dir;

        subdirs =
          filterAttrs (_: type: type == "directory") entries;

        here =
          if builtins.pathExists (dir + "/default.nix")
          then [{
            name = prefix;
            value = import (dir + "/default.nix");
          }]
          else [];

        nested =
          builtins.concatLists (
            mapAttrsToList
              (name: _:
                collect
                  (dir + "/${name}")
                  (if prefix == "" then name else "${prefix}/${name}")
              )
              subdirs
          );
      in
        here ++ nested;

  pairs = collect modulesDir "";

in
  listToAttrs pairs

