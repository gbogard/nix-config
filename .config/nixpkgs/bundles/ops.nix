{ lib, ... }:
let
  inherit (import ../pkgs.nix) unstable;
  machine = (import ../machine.nix);
in
lib.mkMerge [
  {
    home.packages = with unstable; [
      kubectl
      awscli2
      sqlite
    ];
  }
]
