env:
env.lib.mkMerge [
  (import ./haskell.nix env)
  (import ./nix.nix env)
  (import ./purescript.nix env)
  (import ./rescript.nix env)
  (import ./rust.nix env)
  (import ./scala.nix env)
  (import ./web.nix env)
]
