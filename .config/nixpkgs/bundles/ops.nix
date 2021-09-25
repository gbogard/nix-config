{ lib, ... }:
let
  pkgs = (import ../nixpkgs);
  machine = (import ../machine.nix);
in
lib.mkMerge [
  {
    home.packages = with pkgs; [
      kubectl
      awscli2
      sqlite
      drill
      curl
      wget
      youtube-dl
      nodePackages.ngrok
    ];
  }
]
