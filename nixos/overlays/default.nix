final: prev:
prev.lib.mapAttrs' (
  name: _: let
    pkg = prev.lib.removeSuffix ".nix" name;
  in
    prev.lib.nameValuePair pkg (final.callPackage (./. + "/${name}") { })
) (removeAttrs (builtins.readDir ./.) [ "default.nix" ])
