{ pkgs, ...}:

with pkgs; {
  home.packages = [
    kubectl
  ];
}