env:
let
  pkgs = (import ../nixpkgs);
in
{
  home.packages = with pkgs; [
    kubectl
    awscli2
    sqlite
    curl
    wget
    youtube-dl
    backblaze-b2
    wrk
  ];
}
