{ lib, ... }:
let
  pkgs = (import ../nixpkgs);
in
lib.mkMerge [
  (import ../hm-modules/vscode/default.nix)
  (import ../hm-modules/kitty/default.nix)
]
