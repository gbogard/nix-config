env:
env.lib.mkMerge [
  {
    home.username = "guillaumebogard";
    home.homeDirectory = "/Users/guillaumebogard";
  }
  (import ../../hm-modules/base.nix env)
  (import ../../hm-modules/darwin-extras.nix env)
  (import ../../hm-modules/ops-tools.nix env)
  (import ../../hm-modules/vscode env)
  (import ../../hm-modules/neovim env)
  (import ../../hm-modules/kitty env)
  (import ../../hm-modules/shell env)
  (import ../../hm-modules/git env)
  (import ../../hm-modules/programming env)
]
