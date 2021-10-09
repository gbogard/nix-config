self: super:
let 
  additionalPackages = (import ../node-packages { pkgs = self; });
in {
  nodePackages = super.nodePackages // additionalPackages;
}
