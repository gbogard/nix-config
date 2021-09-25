{ lib, ... }:
let
  pkgs =  (import ../nixpkgs);
in
lib.mkMerge [
  {
    home.packages = with pkgs; [
      exa
      procs
      tokei
      bash
      curl
      ripgrep
    ];
  }  
  (import ../packages/zsh/zsh.nix { inherit lib; })
]
