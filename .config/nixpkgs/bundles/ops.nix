{ lib, ... }:
let
  inherit (import ../pkgs.nix) pkgs;
  machine = (import ../machine.nix);
  nodePackages' = (import ../packages/node-packages/default.nix { inherit pkgs; });
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
      nodePackages'.ngrok
      nodePackages'.localtunnel
    ];
  }
]
