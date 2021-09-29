env:
env.lib.mkMerge [
  rec {
    home.username = "guillaume";
    home.homeDirectory = "/home/guillaume";
  }
  (import ../../hm-modules/base.nix env)
  (import ../../hm-modules/neovim env)
  (import ../../hm-modules/shell env)
  (import ../../hm-modules/git env)
  (import ../../hm-modules/programming env)
  (import ../../hm-modules/ops-tools.nix env)
]
