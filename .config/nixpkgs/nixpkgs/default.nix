let
  overlays = (import ./overlays);
in
import
  (
    builtins.fetchTarball {
      url = "https://github.com/NixOS/nixpkgs/archive/5658fadedb748cb0bdbcb569a53bd6065a5704a9.tar.gz";
      sha256 = "1kpmhd9v5a3fbwq86spd1p5s4npfd1jrjl14kl6h1n1l1qd6cbp6";
    }
  )
  { inherit overlays; }
