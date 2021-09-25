self: super: {
  nodePackages = super.nodePackages // (import ../node-packages { pkgs = self; });
}
