env:
env.lib.mkMerge [
  rec {
    home.username = "guillaume";
    home.homeDirectory = "/home/guillaume";
    home.sessionVariables.NIX_PATH =
      "/home/guillaume/.nix-defexpr/channels:"
      + "nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos:"
      + "nixos-config=${home.homeDirectory}/Projects/nix-config/machines/nixos-workstation/configuration.nix:"
      + "/nix/var/nix/profiles/per-user/root/channels";
  }
  (import ../../hm-modules/base.nix env)
  (import ../../hm-modules/neovim env)
  (import ../../hm-modules/shell env)
  (import ../../hm-modules/git env)
  (import ../../hm-modules/programming env)
]
