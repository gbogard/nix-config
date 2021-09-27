env:
let
  pkgs = (import ../../nixpkgs);
in
{
  home.packages = with pkgs; [
    rust-bin.stable.latest.default
  ];
}
