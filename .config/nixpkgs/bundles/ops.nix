{ lib, ... }:
let
  inherit (import ../pkgs.nix) pkgs;
  machine = (import ../machine.nix);
  cronicle = (import ../packages/cronicle/default.nix);
in
lib.mkMerge [
  {
    home.packages = with pkgs; [
      kubectl
      cronicle
      sqlite
    ];
  }
  (lib.mkIf (machine.operatingSystem == "Ubuntu") {
    home.packages = [
      pkgs.docker
    ];
  })
]
