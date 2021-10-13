env:
let
  pkgs = (import ../../nixpkgs);
in
{
  home.packages = with pkgs; with nodePackages; [
    nodejs
    yarn
    geckodriver
    serve
    typescript
    typescript-language-server
    vscode-langservers-extracted
    source-map-explorer
  ];
}
