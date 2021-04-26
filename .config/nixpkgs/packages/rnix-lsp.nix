let
  inherit (import ../pkgs.nix) pkgs;
  src = import (pkgs.fetchFromGitHub {
    owner = "nix-community";
    repo = "rnix-lsp";
    rev = "23df7ab20b71896ac47da8dab6d4bcc6e8f994d5";
    sha256 = "1jrvpw3dfnyj6hplmxd0l0qxxga8fw8mykdnscismcj585ckv3a2";
  });
in
{
  home.packages = [ src ];
}
