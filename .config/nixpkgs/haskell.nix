{ pkgs, ... }:

with pkgs;
with pkgs.haskellPackages;
let
  unstable = import
    (builtins.fetchTarball https://github.com/nixos/nixpkgs/tarball/734c7444071243ba157fef71a880ed1b072abf11)
    { };
in
{
  home.packages = [
    ghc
    idris2
    stack
    hlint
    ormolu
    # Blocked by https://github.com/NixOS/nixpkgs/issues/91748
    # unstable.haskell-language-server
  ];
}
