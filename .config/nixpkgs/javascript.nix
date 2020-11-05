{ pkgs, ... }:

with pkgs; with pkgs.nodePackages; {
  home.packages = [
    nodejs-14_x
    yarn
    typescript
  ];
}
