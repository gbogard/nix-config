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
    vscode-langservers-extracted
    typescript
    typescript-language-server
  ];
}
