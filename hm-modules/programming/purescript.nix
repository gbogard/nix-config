env:
let
  pkgs = (import ../../nixpkgs);
in
{
  home.packages = with pkgs; [
    purs
    spago
    dhall-simple
    zephyr
  ];
}
