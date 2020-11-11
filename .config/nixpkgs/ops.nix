{...}:
let inherit (import ./pkgs.nix) pkgs; in {
  home.packages = with pkgs; [
    kubectl
  ];
}
