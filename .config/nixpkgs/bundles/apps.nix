{ lib, ... }:
let
  inherit (import ../pkgs.nix) pkgs;
in
lib.mkMerge [
  (import ../packages/vscode/default.nix)
  (import ../packages/kitty/default.nix)
  (import ../packages/intellij/default.nix)
]
