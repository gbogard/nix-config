env:
let
  pkgs = (import ../../nixpkgs);
in
{
  home.packages = with pkgs; [
    idris2
    stack
    hlint
    ormolu
    cabal-install
    haskell-language-server
  ];
}
