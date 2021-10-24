let
  pkgs = (import ../../nixpkgs);
in
with pkgs.vscode-extensions; [
  dbaeumer.vscode-eslint
  haskell.haskell
  vscodevim.vim
  pkief.material-icon-theme
] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
  {
    name = "scala";
    publisher = "scala-lang";
    version = "0.5.4";
    sha256 = "1a27yq29g9md98cm1gsb0sjw9hy1jsnqzxd91r7vq7infvcc1i26";
  }
  {
    name = "metals";
    publisher = "scalameta";
    version = "1.10.11";
    sha256 = "10zh04ib6prjc2mlyihp8a6j4j428j7xp64kak1y356shvmccqzs";
  }
  {
    name = "gruvbox-material";
    publisher = "sainnhe";
    version = "6.4.6";
    sha256 = "17xddfkxfgj9qls1364c8iqk359rk0k6fc6xpl93zzqr43hx4vxf";
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
