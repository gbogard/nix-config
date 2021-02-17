{ lib, ... }:
let
  inherit (import ./pkgs.nix) pkgs;
  machine = (import ./machine.nix);
in
lib.mkMerge [
  (lib.mkIf (machine.operatingSystem == "Ubuntu") {
    home.packages = [
      pkgs.docker
    ];
  })
]
