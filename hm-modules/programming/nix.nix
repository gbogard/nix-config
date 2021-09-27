env:
let
  pkgs = (import ../../nixpkgs);
in
{
  home.packages = [ pkgs.rnix-lsp ];
}
