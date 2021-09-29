env:
let
  pkgs = (import ../nixpkgs);
in
{
  home.packages = with pkgs; [
    kubectl
    awscli2
    sqlite
    drill
    curl
    wget
    youtube-dl
    backblaze-b2
  ];
}
