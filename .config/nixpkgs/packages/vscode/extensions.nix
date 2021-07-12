let
  inherit (import ../../pkgs.nix) unstable;
in
with unstable.vscode-extensions; [
  dbaeumer.vscode-eslint
  scalameta.metals
  haskell.haskell
  vscodevim.vim
] ++ unstable.vscode-utils.extensionsFromVscodeMarketplace [
  {
    name = "gruvbox-material";
    publisher = "sainnhe";
    version = "6.4.4";
    sha256 = "1g224vl307n6yphsmh22i4m9795pj2paiddm4ml8z2q0zwm2i0mh";
  }
  {
    name = "vscode-xml";
    publisher = "redhat";
    version = "0.16.1";
    sha256 = "04c8fj2ng7fiafib2p7gxyxw1l7mvys0057wwgqgyasrq9i7jd3g";
  }
  {
    name = "vscode-commons";
    publisher = "redhat";
    version = "0.0.6";
    sha256 = "1b8nlhbrsg3kj27f1kgj8n5ak438lcfq5v5zlgf1hzisnhmcda5n";
  }
  {
    name ="remote-ssh";
    publisher = "ms-vscode-remote";
    version = "0.65.7";
    sha256 = "10ynl4pzlxy2k8f2zk3nfkp81br12a2aa6hzpd3zfnpwg6zc91mf";
  }
]
