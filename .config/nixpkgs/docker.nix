{ lib, ... }:
let
  inherit (import ./pkgs.nix) pkgs;
  machine = (import ./machine.nix);
in
lib.mkMerge [
  (lib.mkIf (machine.hostname == "nananas-xubuntu") {
    home.packages = [
      pkgs.docker
    ];
  })
]
