{ lib, ... }:
let
  pkgs = (import ../nixpkgs);
in
lib.mkMerge [
  (import ../packages/vscode/default.nix)
  (import ../packages/kitty/default.nix)
]
