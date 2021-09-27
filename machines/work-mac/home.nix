env:
env.lib.mkMerge [
  {
    home.username = "gbogard";
    home.homeDirectory = "/Users/gbogard";
  }
  (import ../../hm-modules/base.nix env)
  (import ../../hm-modules/darwin-extras.nix env)
  (import ../../hm-modules/ops-tools.nix env)
  (import ../../hm-modules/vscode env)
  (import ../../hm-modules/neovim env)
  (import ../../hm-modules/kitty env)
  (import ../../hm-modules/shell env)
  (import ../../hm-modules/git env)
  (import ../../hm-modules/programming/scala.nix env)
  (import ../../hm-modules/programming/haskell.nix env)
  (import ../../hm-modules/programming/nix.nix env)
  (import ../../hm-modules/programming/web.nix env)
  (import ../../hm-modules/programming/rescript.nix env)
]
