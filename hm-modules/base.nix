{ lib, ... }:
let
  pkgs = (import ../nixpkgs);
in
{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  home.packages = with pkgs; [
    nix-prefetch-scripts
    nixpkgs-fmt
    htop
    ripgrep
  ];
  home.stateVersion = "21.03";
}
